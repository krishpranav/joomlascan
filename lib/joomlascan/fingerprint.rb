module JoomlaScan
    module Fingerprint
        def check_user_registration
            print_line_break
            print_verbose('Checking if registration is enabled..')
            print_warning("Registration is enabled: #{fingerprint_scanner.target_uri}#{fingerprint_scanner.registration_uri}") if fingerprint_scanner.user_registration_enabled
            print_verbose('User registration is not enabled.') if !fingerprint_scanner.user_registration_enabled
        end

        def inspect_headers
            print_line_break if opts[:verbose]
            print_verbose('Looking for intresting headers.....')
            intresting_headers = fingerprint_scanner.intresting_headers
            print_good("Found #{intresting_headers.length} intresting headers....")
            intresting_headers.each do |header|
                print_indent("#{header[0]}: #{header[1]}")
            end
        end
        