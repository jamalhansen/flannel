module Flannel
  class Square
    attr_accessor :preformatted
    
    def initialize params={}
      @preformatted = params[:preformatted] == true
      @lines = []
    end

    def << str
      @lines << str
    end

    def to_s
      @lines.join("\n")
    end

    def blank?
      @lines.length == 0 || @lines[0].strip == ""
    end

    def to_h
      if @preformatted
        first_line = @lines[0][1..@lines[0].length]
        if empty? first_line
          @lines = @lines[1..@lines.length-1]          #remove first line if it's just an underscore
        else
          @lines[0] = first_line #remove underscore
        end

        last = @lines.length-1
        last_line = @lines[last][1..@lines[0].length]
        if empty? last_line
          @lines = @lines[0..last-1]          #remove last line if it's just an underscore
        else
          @lines[last] = last_line #remove underscore
        end

        html = @lines.join("\n")
        html = wrap html, "pre"
      else
        @post_wrap = nil
        html = @lines.map { |p| markup p }.join("\n")
        html = wrap html, @post_wrap
      end
    end

    def markup text
      parts = text.match(/^(\W+) (.*)/)

      if parts
        case parts[1][0]
        when 42  # * - list
          text = text[1..text.length].strip
          tag = "li"
          @post_wrap = "ul"
        when 61  # = - header
          tag = "h#{parts[1].length}"
          text = parts[2]
        end
      else
        tag = "p"
      end

      wrap text, tag
    end

    def wrap content, tag
      if empty?(content) || empty?(tag)
        return content
      end

      content.strip! unless tag == "pre"

      "<#{tag}>#{content}</#{tag}>"
    end

    def empty? str
      str.nil? || str.strip == ""
    end
  end
end
