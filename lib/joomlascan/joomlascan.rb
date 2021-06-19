module JoomlaScan
    attr_reader :opts
    attr_reader :fingerprint_scanner
    attr_reader :target
    attr_reader :joomla_version
    

    def abort_scan
        print_line_break
        print_good('Scan aborted')
        exit(1)
    end

    def has_target
        !opts[:url].nil? && !opts[:url].empty?
    end

    def joomla_vulnerabilities
        json = File.read(File.join(ExtensionScanner.base_path, 'data/joomla.json'))
        vulns = JSON.parse(json)
        found = []
        
        vulns.each do |v|
            found.push(v) if ExtensionScanner.version_is_vulnerable(Gem::Version.new(joomla_version), v)
        end
        
        found
    end

    def display_joomla_vulns
        return unless joomla_version

        joomla_vulns = joomla_vulnerabilities
        return unless joomla_vulns

        print_warning("Found #{joomla_vulns.length} vulnerabilities affecting this version of Joomla!")
        display_vulns(joomla_vulns)
    end
end
