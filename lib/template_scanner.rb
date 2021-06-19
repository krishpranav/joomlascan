require_relative 'extension_scanner'


class TemplateScanner < ExtensionScanner
  def initialize(target_uri, opts)
    super(target_uri, 'data/templates.json', opts)
  end

  def directory_name
    'templates'
  end

  def queue_requests(name, path_index = 0, &block)
    paths = possible_paths(name)
    return unless path_index < paths.length
    queue_manifest_request('templateDetails.xml', paths, name, path_index, &block)
  end

  def get_hrefs_from_links(links)
    hrefs = links.map { |link| link.attribute('href').to_s }
    hrefs = hrefs.uniq.sort.delete_if { |href| href.empty? || href.start_with?('?') || href == '/' }
    hrefs
  end

  def extract_extensions_from_page(url)
    req = create_request(url)
    matches = []

    req.on_complete do |resp|
      doc = Nokogiri::HTML(resp.body)
      links = doc.css('a')
      hrefs = get_hrefs_from_links(links)
      matches = hrefs.map { |href| href.match(/\/?([a-z0-9\-_]+)\/?$/i)[1] }
    end

    req.run
    matches
  end

  def extract_list_from_home
    pattern = /(\/administrator)?\/templates\/[a-z0-9\-\._]+/i
    url = '/'
    matches = extract_extension_list_from_page(url, pattern)
    matches.map { |m| m.sub(/^(\/administrator)?\/templates\//i, '') }
  end
end
