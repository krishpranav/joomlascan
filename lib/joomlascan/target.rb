module JoomlaScan
    module Target
        def update_target_uri(new_uri)
            fingerprint_scanner.update_target_uri new_uri
            print_verbose("Now targetting #{fingerprint_scanner.target_uri}")
        end
        