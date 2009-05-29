module Flannel
  class MarkupToHtml
    def to_h markup
      paragraphs = split_into_text_blocks markup

      paragraphs.map { |p| wrap "<p>", "#{p}", "</p>\n" }.join("\n")
    end

    def blank? str
      str.nil? || str == ""
    end

    def wrap pre, content, post
      return content if blank?(content.strip)
      
      "#{pre}#{content.strip}#{post}"
    end

    def split_into_text_blocks markup
      paragraphs = []
      paragraph = ""
      last_line = ""

      lines = markup.split("\n").each do |line|
        if (blank?(line.strip))
          paragraphs << paragraph
          paragraph = ""
        else
          paragraph << line
        end
      end

      paragraphs << paragraph
    end
  end
end
