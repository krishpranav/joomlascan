# requires
require 'json'
require 'nokogiri'
require_relative 'scanner'

class ExtensionScanner < Scanner
    def initialize(target_uri, data_file, opts)
        super(target_uri, opts)
        @data_file = File.join(ExtensionScanner.base_path, data_file)
    end

    def self.base_path
        @@base_path ||= nil
        return @@base_path unless @@base_path.nil?

        base = __FILE__

        while File.symlink?(base)
            base = File.expand_path(File.readlink(base), File.dirname(base))
        end

        @@base_path = File.dirname(File.expand_path(File.join(File.dirname(base))))
    end

    def root_element_xpath
        '//*'
    end
    
    def get_version_from_manifest(manifest)
        version_text = manifest.xpath("#{root_element_xpath}/version").text

        begin
            version = Gem::Version.new(version_text)
        rescue
            version_number = extract_version_number(version_text)
            version = Gem::Version.new(version_number) if version_number
        ensure 
            return version
        end
    end

    def create_extension_from_manifest(xml, extension_path, manifest_uri)
        manifest = Nokogiri::XML(xml)
        {
          version: get_version_from_manifest(manifest),
          name: manifest.xpath("#{root_element_xpath}/name").text,
          author: manifest.xpath("#{root_element_xpath}/author").text,
          author_url: manifest.xpath("#{root_element_xpath}/authorUrl").text,
          extension_url: "#{target_uri}#{extension_path}",
          manifest_url: "#{target_uri}#{manifest_uri}",
          description: manifest.xpath("#{root_element_xpath}/description").text,
          vulns: []
        }
    end

    def process_result(ext, extension_path, manifest_uri, res)
        extension = create_extension_from_manifest(res, extension_path, manifest_uri)
        ext['vulns'].each do |v|
            extension[:vulns].push(v) if ExtensionScanner.version_is_vulnerable(extension[:version], v)
        end
        extension
    end

    def extension_prefix
        ''
    end

    def directory_name
        ''
    end

    def possible_paths(name)
        paths = []
        paths.push(normalize_uri('administrator', directory_name, "#{extension_prefix}#{name}"))
        paths.push(normalize_uri(directory_name, "#{extension_prefix}#{name}"))
        paths
    end

    def queue_manifest_request(manifest_name, paths, name, path_index, &block)
        uri = normalize_uri(paths[path_index], manifest_name)
        req = create_request(uri)
        req.on_complete do |resp|
            if resp.code == 200
                block.call(resp, paths[path_index], uri)
            else
                queue_requests(name, path_index + 1, &block)
            end
        end

        hydra.queue req
    end

    def queue_requests(name, path_index = 0, &block)
        paths = possible_paths(name)
        return unless path_index < paths.length
    

        uri = normalize_uri(paths[path_index], "#{name}.xml")
        req = create_request(uri)
        req.on_complete do |resp|
          if resp.code == 200

            block.call(resp, paths[path_index], uri)
          else

            queue_manifest_request('manifest.xml', paths, name, path_index, &block)
          end
        end
    
        hydra.queue req
    end

    def self.version_in_range(version, range)
        in_range = false
    
        if range['introduced_in'].nil? || Gem::Version.new(range['introduced_in']) <= version
          if range['fixed_in'].nil? || Gem::Version.new(range['fixed_in']) > version
            in_range = true
          end
        end
    
        in_range
    end

    def self.version_is_vulnerable(version, vuln)
        found = false

        if vuln['ranges']
            vuln['ranges'].each do |range|
                found = version_in_range(version, range)
                break if found
            end
        else
            found = version_in_range(version, vuln)
        end

        found
    end

    def data_file_json
        JSON.parse(File.read(@data_file))
    end

    def apply_filter(extension, filter)
        extensions.delete_if { |e| !filter.include? e['name']} unless filter.empty?
        extensions
    end

    def scan(filter)
        return [] unless filter
        extensions = apply_filter(data_file_json, filter)
        detected = []
        lock = Mutex.new
    
        extensions.each do |e|
          queue_requests(e['name']) do |resp, extension_path, manifest_uri|
            lock.synchronize do
              res = process_result(e, extension_path, manifest_uri, resp.body)
              detected.push(res) if res[:vulns].length > 0
            end
          end
        end
    
        hydra.run
        detected
    end
    
