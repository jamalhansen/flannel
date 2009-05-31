require 'square'

module Flannel
  class Shears
    def to_h markup
      squares = cut_into_squares markup
      squares.map { |square| square.to_h }.join("\n\n")
    end

    def empty? str
      str.nil? || str == ""
    end

    def cut_into_squares markup
      squares = []
      square = Flannel::Square.new
      @preformatted = false

      lines = markup.split("\n").each do |line|
        if (empty?(line.strip) && !@preformatted)
          if !square.blank?
            squares << square
          end

          square = Flannel::Square.new
        else
          if line[0] == 95
            @preformatted = !@preformatted
            square.preformatted = true
          end

          square << line
        end
      end

      squares << square
    end
  end
end
