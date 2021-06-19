require_relative 'extension_scanner'

class ComponentScanner < ExtensionScanner
    def initialize(target_uri, opts)
        super(target_uri, 'data/components.json', opts)
    end

    def extension_prefix
        'com_'
    end
    