require_relative 'scanner'

class FingerprintScanner < Scanner

    def initialize(target_uri, opts)
        super(target_uri, opts)

        @cached_index_results = {}
    end
    