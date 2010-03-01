require 'flannel/wrappable'

module Flannel
  
  # Methods for transforming test into html
  module HtmlTransformable
    include Wrappable
    
    def html_escape text
      require 'cgi'

      CGI::escapeHTML(text)
    end
    
    def permalink topic
      topic.gsub(%r{[^/\w\s\-]},'').gsub(%r{[^\w/]|[\_]},' ').split.join('-').downcase
    end
    
    def build_wiki_links text
      text.gsub(/-\w(.*?)\w>/) { |match| %{<a href="#{wiki_link match}">#{format_link_display(match)}</a>}}
    end
    
    def create_img text
      desc, url = text.split(/\n/, 2)
      
      return text unless url
      
      "<img src='#{url}' alt='#{desc}' title='#{desc}' />"
    end
    
    def wiki_link topic
      permalink topic[1..-2]
    end

    def permalink topic
      topic.gsub(%r{[^/\w\s\-]},'').gsub(%r{[^\w/]|[\_]},' ').split.join('-').downcase
    end
    
    def format_link_display text
      text[1..-2].split("/").last
    end
    
    def convert_external_links text
      text.gsub(/\[([^\|]*\|[^\]]*)\]/) { |match| build_external_link match }
    end

    def build_external_link match
      text, url, title = match[1..-2].split("|", 3).map { |part| part.strip }

      url = format_link url

      if title
        %{<a href="#{url}" title="#{title}" target="_blank">#{text}</a>}
      else
        %{<a href="#{url}" target="_blank">#{text}</a>}
      end
    end
    
    def format_link url
      return url if /:\/\// =~ url
      "http://#{url}"
    end
    
    def format_list text
      text.split(/\n/).reject { |item| item == ""  }.map { |item| wrap(item.chomp, "li") }.join("\n")      
    end
    
    def format_dlist text
      text.split(/\n/).reject { |item| item == ""  }.map { |item| split_definition(item) }.join("\n")      
    end
    
    def split_definition item
      term, definition = item.split(/\-/, 2).map{ |term| term.strip }
      
      return item unless definition
      "<dt>#{term}</dt><dd>#{definition}</dd>"
    end
    
    def parse_feed text
      parser = Flannel::FeedParser.new  Flannel.cache
      parser.sub_feeds text
    end
  end
end