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
    