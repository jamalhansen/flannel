module Flannel
  class HtmlFormatter
    include Wrappable
    
    def initialize
      @tags ={:preformatted => "pre", 
              :feed => "ul", 
              :list => "ul", 
              :header_1 => "h1", 
              :header_2 => "h2", 
              :header_3 => "h3", 
              :header_4 => "h4", 
              :header_5 => "h5", 
              :header_6 => "h6", 
              :paragraph => "p",
              :blockquote => "blockquote"}
    end
    
    def do text, style
      steps = get_steps_for style
      inject text, steps
    end

    def permalink topic
      topic.gsub(%r{[^/\w\s\-]},'').gsub(%r{[^\w/]|[\_]},' ').split.join('-').downcase
    end
    
    def inject text, steps
      if steps.empty?
	text
      else
	step = steps.shift
	text = step.call text
	inject text, steps
      end
    end
    
    def get_steps_for style
      steps = []
      
      case style
	
      when :preformatted
	steps << lambda { |text| html_escape text}
      when :feed
	steps << lambda { |text| parse_feed text }
      else
	steps << lambda { |text| build_wiki_links text }
	steps << lambda { |text| convert_external_links text }
      end
      
      if style == :list
	steps << lambda { |text| format_list text }
      end
      
      steps << lambda { |text| wrap text, @tags[style]}
      
      steps
    end
    
    def html_escape text
      require 'cgi'

      CGI::escapeHTML(text)
    end
    
    def build_wiki_links text
      text.gsub(/-\w(.*?)\w>/) { |match| %{<a href="#{wiki_link match}">#{format_link_display(match)}</a>}}
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
      text, url, title = match[1..-2].split("|", 3)

      url = format_link url.strip
      text.strip!
      title.strip! if title

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
      text.split(/^\*/).reject { |item| item == ""  }.map { |item| wrap(item.chomp, "li") }.join("\n")      
    end
    
    def parse_feed text
      parser = Flannel::FeedParser.new  Flannel.cache
      parser.sub_feeds text
    end
  end
end