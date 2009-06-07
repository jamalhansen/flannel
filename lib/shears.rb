require 'square'
require 'stripe'

module Flannel
  class Shears
    def initialize params={}
      @wiki_link= params[:wiki_link]
    end

    def cut markup
      squares = cut_into_squares markup
      squares.map { |square| square.to_h }.join("\n\n")
    end

    def empty? str
      str.nil? || str == ""
    end

    def cut_into_squares markup
      squares = []
      square = Flannel::Square.new
      end_preformat = false

      markup.split("\n").each do |line|
        if need_new_square? square, line, end_preformat
          squares << square unless square.blank?
          square = Flannel::Square.new
        else
          stripe_text, end_preformat = add_to square, line
          square << stripe_text if stripe_text
        end
      end

      squares << square
    end

    def need_new_square? square, line, end_preformat
      square.style == :preformatted ? end_preformat : empty?(line.strip)
    end
    
    def add_to square, line
      preformatted_marker_line = false
      parts = line.match(/^([=_*]+)(.*)/)
      first = parts[1] if parts 

      if first
        case first[0]
        when 61               # equals (header)
          style = "header_#{first.length}"
          square.style = style.to_sym
        when 95               # underscore (preformatted)
          square.style = :preformatted
          preformatted_marker_line = true
        when 42               # star (list)
          square.style = :list
        end
      end

      if preformatted_marker_line
        end_preformat = square.populated?
        stripe_text = parts[2] unless parts[2].strip == ""
      else
        end_preformat = false
        stripe_text = line
      end

      [stripe_text, end_preformat]
    end
  end
end

