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
    