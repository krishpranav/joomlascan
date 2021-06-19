module JoomlaScan
    module Extensions
        def display_reference(ref, base_url = nil)
            return unless ref
            if ref.is_a?(Array)
                ref.each do |id|
                    print_indent("Refernce: #{base_url}#{id}")
                end
            else
                print_indent("Reference: #{base_url}#{ref}")
            end
        end
        