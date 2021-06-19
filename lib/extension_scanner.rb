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
    