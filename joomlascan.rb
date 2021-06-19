# requires
require 'slop'
require 'typhoeus'
require_relative 'lib/cache'
Typhoeus::Config.cache = Cache.new
require_relative 'lib/joomlavs/helper'

