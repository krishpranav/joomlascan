module JoomlaScan
    module Components
        def build_components_filter(scanner)
            scanner.build_filter(fingerprint_scanner.components_listing_enabled, fingerprint_scanner.administrator_components_listing_enabled)
        end

        def scan_components
            scan(:Components, ComponentScanner, opts[:scan_components])
        end
    end
end

