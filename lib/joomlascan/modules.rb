module JoomlaScan
    module Modules
        def build_modules_filter(scanner)
            scanner.build_filter(fingerprint_scanner.modules_listing_enabled, fingerprint_scanner.administrator_modules_listing_enabled)
        end
        