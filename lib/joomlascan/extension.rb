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

        def display_vulns(vulns)
            vulns.each do |v|
              print_line_break
              print_error("Title: #{v['title']}")
              display_reference v['edbid'], 'https://www.exploit-db.com/exploits/'
              display_reference v['cveid'], 'http://www.cvedetails.com/cve/CVE-'
              display_reference v['url']
              print_info("Fixed in: #{v['fixed_in']}") if v['fixed_in']
              print_line_break
            end
        end
        