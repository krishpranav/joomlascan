require_relative 'extension_scanner'

class ModuleScanner < ExtensionScanner
    def initialize(target_uri, opts)
        super(target_uri, 'data/modules.json', opts)
    end

    def extension_prefix
        'mod_'
    end

    def directory_name
        'modules'
    end
end
