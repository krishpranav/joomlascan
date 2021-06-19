require 'typhoeus'

class Scanner
    def initialize(target_uri, opts)
        update_target_uri target_uri
        @opts = opts
        @hydra = Typhoeus::Hydra.new(max_concurrency: opts[:threads])
    end

    def target_uri
        @target_uri
    end

    def update_target_uri(value)
        @target_uri = value.chomp('/')
    end

    def hydra
        @hydra
    end

    def follow_redirection
        @opts[:follow_redirection]
    end
    