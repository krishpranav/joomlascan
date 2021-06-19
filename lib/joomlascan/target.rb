module JoomlaScan
    module Target
        def update_target_uri(new_uri)
            fingerprint_scanner.update_target_uri new_uri
            print_verbose("Now targetting #{fingerprint_scanner.target_uri}")
        end

        def verify_target_change(new_uri)
            print_info("The remote host tried to redirect to: #{new_uri}")
            answer = read_input('Do you want to follow the redirection?? [Y]es [N]o [A]bort: ')
            if answer =~ /^y/i
                update_target_uri(new_uri)
            elsif answer =~ /^a/i
                abort_scan
            end
        end
        