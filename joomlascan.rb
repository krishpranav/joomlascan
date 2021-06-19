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

    def initialize
        initialize_options
        @use_colours = !opts[:no_colour]
        @target = opts[:url]
    end

    def initialize_options
        @opts = Slop.parse do |o|
          o.separator 'Basic options'
          o.string '-u', '--url', 'The Joomla URL/domain to scan.'
          o.string '--basic-auth', '<username:password> The basic HTTP authentication credentials'
          o.bool '-v', '--verbose', 'Enable verbose mode'
    
          o.separator 'Enumeration options'
          o.bool '-a', '--scan-all', 'Scan for all vulnerable extensions'
          o.bool '-c', '--scan-components', 'Scan for vulnerable components'
          o.bool '-m', '--scan-modules', 'Scan for vulnerable modules'
          o.bool '-t', '--scan-templates', 'Scan for vulnerable templates'
          o.bool '-q', '--quiet', 'Scan using only passive methods'
    
          o.separator 'Advanced options'
          o.bool '--disable-tls-checks', 'Disable SSL/TLS certificate verification.'
          o.bool '--follow-redirection', 'Automatically follow redirections'
          o.bool '--no-colour', 'Disable colours in output'
          o.string '--proxy', '<[protocol://]host:port> HTTP, SOCKS4 SOCKS4A and SOCKS5 are supported. If no protocol is given, HTTP will be used'
          o.string '--proxy-auth', '<username:password> The proxy authentication credentials'
          o.integer '--threads', 'The number of threads to use when multi-threading requests', default: 20
          o.string '--user-agent', 'The user agent string to send with all requests', default: 'Mozilla/5.0 (Windows NT 6.3; rv:36.0) Gecko/20100101 Firefox/36.0'
          o.bool '--hide-banner', 'Do not show the JoomlaVS banner'
        end
    end

    def execute_fingerprinting_tasks
        @fingerprint_scanner = FingerprintScanner.new(opts[:url], opts)
        check_target_redirection
        @target = fingerprint_scanner.target_uri
        check_user_registration
        inspect_headers
        check_indexes
        determine_joomla_version
    end

    def scan_extensions
        scan_components
        scan_modules
        scan_templates
    end

    def start
        execute_fingerprinting_tasks
        display_joomla_vulns
        scan_extensions
    end
end

app = Application.new
app.print_banner unless app.opts[:hide_banner]


if app.has_target
    app.print_good("URL: #{app.target}")
    app.print_good("Started #{Time.now.asctime}")
    app.start
    app.print_line_break
    app.print_good 'Finished'
else
    puts app.opts
end

    