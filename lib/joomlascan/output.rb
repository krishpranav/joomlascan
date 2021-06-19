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

    def print_good(text)
      if use_colours
        print_line('[+]'.green, text)
      else
        print_line('[+]', text)
      end
    end

    def print_warning(text)
      if use_colours
        print_line('[!]'.yellow, text)
      else
        print_line('[!]', text)
      end
    end

    def print_info(text)
      if use_colours
        print_line('[i]'.cyan, text)
      else
        print_line('[i]', text)
      end
    end

    def print_error(text)
      if use_colours
        print_line('[!]'.red, text)
      else
        print_line('[!]', text)
      end
    end

    def print_indent(text)
      if use_colours
        print_line(' | '.light_white, text)
      else
        print_line(' | ', text)
      end
    end

    def print_line_break
      puts ''
    end

    def print_horizontal_rule
      puts '------------------------------------------------------------------'
    end

    def print_indent_unless_empty(text, var)
      print_indent(text) unless var.empty?
    end

    def print_verbose(text)
      print_info(text) if opts[:verbose]
    end
  end
end
