require 'square'
require 'stripe'

module Flannel
  class Shears
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
      @square = Flannel::Square.new
    end

    def need_new_square? line
      @square.style == :preformatted ? @end_preformat : empty?(line.strip)
    end

    def add line
      preformatted_marker_line = false
      parts = line.match(/^([=_*]+)(.*)/)
      first = parts[1] if parts

      if first
        case first[0]
        when 61               # equals (header)
          style = "header_#{first.length}"
          @square.style = style.to_sym
        when 95               # underscore (preformatted)
          @square.style = :preformatted
          preformatted_marker_line = true
        when 42               # star (list)
          @square.style = :list
        end
      end

      if preformatted_marker_line
        @end_preformat = @square.populated?
        stripe_text = parts[2] unless parts[2].strip == ""
      else
        @end_preformat = false
        stripe_text = line
      end

      @square << stripe_text unless stripe_text.nil?
    end

    def empty? str
      str.nil? || str == ""
    end
  end
end

