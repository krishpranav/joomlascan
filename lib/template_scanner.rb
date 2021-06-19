require_relative 'extension_scanner'

class TemplateScanner < ExtensionScanner
    def initialize(target_uri, opts)
        super(target_uri, 'data/templates.json', opts)
    end
    