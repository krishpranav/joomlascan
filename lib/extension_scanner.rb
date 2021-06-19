# requires
require 'json'
require 'nokogiri'
require_relative 'scanner'

class ExtensionScanner < Scanner
    def initialize(target_uri, data_file, opts)
        super(target_uri, opts)
        @data_file = File.join(ExtensionScanner.base_path, data_file)
    end
    