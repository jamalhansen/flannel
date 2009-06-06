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
      preformatted = false

      markup.split("\n").each do |line|
        preformatted_marker_line = false

        if (empty?(line.strip) && !preformatted)
          unless square.blank?
            squares << square
            preformatted = false
          end

          square = Flannel::Square.new
        else
          parts = line.match(/^([=_*]+)(.*)/)
          first = parts[1] if parts

          if first
            case first[0]
            when 61               # equals (header)
              square.style = :header
              square.style_detail = first.length
            when 95               # underscore (preformatted)
              preformatted = !preformatted
              square.style = :preformatted
              preformatted_marker_line = true
            when 42               # star (list)
              square.style = :list
            end
          end

          if preformatted_marker_line
            square << parts[2] unless parts[2].strip == ""
          else
            square << line
          end
        end
      end

      squares << square
    end
  end
end
