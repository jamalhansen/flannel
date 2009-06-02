module Flannel
  class Square
    attr_accessor :preformatted
    
    def initialize params={}
      @preformatted = params[:preformatted] == true
      @wiki_link= params[:wiki_link]
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
        clean_stray_underscores
        html = @lines.join("\n")
        html = wrap html, "pre"
      else
        @post_wrap = nil
        html = @lines.map { |p| markup p }.join("\n")
        html = wrap html, @post_wrap
      end
    end

    def markup text
      text = build_wiki_links text

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

    def wiki_link topic
      @wiki_link.call(permalink topic)
    end

    def permalink topic
      require 'iconv'
      # thanks to ismasan http://snippets.dzone.com/posts/show/4457
      (Iconv.new('US-ASCII//TRANSLIT', 'utf-8').iconv topic).gsub(/[^\w\s\-\â€”]/,'').gsub(/[^\w]|[\_]/,' ').split.join('-').downcase
    end

    def clean_stray_underscores
      @lines = trim_underscore @lines, 0
      @lines = trim_underscore @lines, @lines.length-1
    end

    def trim_underscore list, line_num
      line = list[line_num][1..-1]

      if empty? line
        list.delete_at line_num     #remove line if it's just an underscore
      else
        list[line_num] = line #remove underscore
      end
      list
    end

    def build_wiki_links text
       text.gsub(/-(.*)>/) { |match| %{<a href="#{wiki_link match}">#{match[1..-2]}</a>}}
    end
  end
end

