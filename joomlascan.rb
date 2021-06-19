# requires
require 'slop'
require 'typhoeus'
require_relative 'lib/cache'
Typhoeus::Config.cache = Cache.new
require_relative 'lib/joomlavs/helper'

$stdout.sync = true


class Application
    include JoomlaScan
    include JoomlaScan::Output
    include JoomlaScan::Extensions
    include JoomlaScan::Components
    include JoomlaScan::Target
    include JoomlaScan::Version
    include JoomlaScan::Fingerprint
    include JoomlaScan::Modules
    include JoomlaScan::Templates
