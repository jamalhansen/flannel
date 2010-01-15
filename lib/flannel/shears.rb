#require 'square'
#require 'stripe'

module Flannel
  class Shears
    def initialize params={}
      @params = params
    end
    
    def cut markup
      @squares = []
      @square = Flannel::Square.new
      @end_preformat = false

      markup.split("\n").each { |line| cut_into_squares line }

      @squares << @square
    end

    def cut_into_squares line
     if need_new_square? line
        shift_square
      else
        add line
      end
    end

    def shift_square
      @squares << @square unless @square.blank?
      @square = Flannel::Square.new @params
    end

    def need_new_square? line
      @square.style == :preformatted ? @end_preformat : empty?(line.strip)
    end

    def add line
      @preformatted_marker_line = false
      line = strip_markers line
      line = remove_hanging_preformatted_lines line

      @square << line unless line.nil?
    end

    def remove_hanging_preformatted_lines line
      if @preformatted_marker_line
        @end_preformat = @square.populated?
        if line.strip == ""
          return nil
        end
      else
        @end_preformat = false
      end
      line
    end

    def strip_markers line
      parts = line.match(/^([=_*&]+)(.*)/)

      if parts
        set_style parts[1]
        line = parts[2]
      end
      line
    end

    def set_style marker
      if marker
        case marker[0]
        when 61               # equals (header)
          style = "header_#{marker.length}"
          @square.style = style.to_sym
        when 95               # underscore (preformatted)
          @square.style = :preformatted
          @preformatted_marker_line = true
        when 42               # star (list)
          @square.style = :list
	when 38              # ampersand (feed)
          @square.style = :feed
        end
      end
    end

    def empty? str
      str.nil? || str == ""
    end
  end
end

