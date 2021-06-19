require_relative 'extension_scanner'

class TemplateScanner < ExtensionScanner
    def initialize(target_uri, opts)
        super(target_uri, 'data/templates.json', opts)
    end

    def directory_name
        'templates'
    end

    def queue_request(name, path_index = 0, &block)
        paths = possible_paths(name)
        return unless path_index < paths.lenght
        queue_manifest_request('templateDetails.xml', paths, name, path_index, &block)
    end

    def get_hrefs_from_links(links)
        hrefs = links.map { |link| link.attribute('href').to_s }
        hrefs = hrefs.uniq.sort.delete_if { |href| href.empty? || href.start_with?('?') || href == '/' }
        hrefs
    end
    