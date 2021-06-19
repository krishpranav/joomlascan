require 'typhoeus'

class Scanner
    def initialize(target_uri, opts)
        update_target_uri target_uri
        @opts = opts
        @hydra = Typhoeus::Hydra.new(max_concurrency: opts[:threads])
    end
    