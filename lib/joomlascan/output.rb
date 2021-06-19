# requires
require 'colorize'
require 'readline'

module JoomlaScan
    module Output
        attr_accessor :use_colours

        def print_line(prefix, text, new_line = true)
            print prefix

            if use_colours
                print " #{text}".light_white
            else
                print " #{text}"
            end
            
            print "\r\n" if new_line
        end

        def print_banner
            banner = %(
                JOOMLA SCANNER
            )
            print banner.light_white if use_colours
            print banner unless use_colours
        end

        def read_input(prompt)
            if use_colours
                print_line('[?]'.light_white, prompt, false)
            else
                print_line('[?]', prompt, false)
            end

            Readline.readline
        end
        