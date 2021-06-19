module JoomlaScan
    module Templates
        def build_template_filter(scanner)
            scanner.build_filter(fingerprint_scanner.templates_listing_enabled, fingerprint_scanner.administrator_templates_listing_enabled)
        end

        def scan_templates
            scan(:templates, TemplateScanner, opts[:scan_templates])
        end
    end
end
