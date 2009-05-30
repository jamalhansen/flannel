module Flannel
  class MarkupToHtml
    def to_h markup
      paragraphs = split_into_text_blocks markup

      paragraphs.map { |p| markup p }.join("\n\n")
    end

    def blank? str
      str.nil? || str == ""
    end

    def markup text
      parts = text.match(/^(=+) (.*)/)

      if parts
        tag = "h#{parts[1].length}"
        text = parts[2]
      else
        tag = "p"
      end

      wrap text, tag
    end

    def wrap content, tag
      return content if blank?(content.strip)
      
      "<#{tag}>#{content.strip}</#{tag}>"
    end

    def split_into_text_blocks markup
      paragraphs = []
      paragraph = ""
      last_line = ""

      lines = markup.split("\n").each do |line|
        if (blank?(line.strip))
          if !blank?(paragraph.strip)
            paragraphs << paragraph
          end
          
          paragraph = ""
        else
          paragraph << line
        end
      end
      
      paragraphs << paragraph
    end
  end
end
