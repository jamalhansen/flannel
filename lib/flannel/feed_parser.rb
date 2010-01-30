require 'open-uri'

module Flannel
  class FeedParser
    def initialize cache=nil
      @cache = cache
    end
    
    def sub_feeds(url)
      url = format_url(url)
      get_news(url)
    end
    
    def format_url url
      url.strip!
      url = "http://#{url}" if url[0..6] != "http://"
      url
    end
    
    def get_document url
      URI.parse(url).read
    end
    
    def format_item(link, title)
      "  <li>\n    <a href='#{link}'>#{title}</a>\n  </li>\n"
    end

    def get_news url
      item_string = nil
      item_string = @cache.retrieve(url) if @cache
      
      unless item_string 
	item_string = ""
	doc = get_document(url)
	items = get_items(doc)

	items.each do |item|
	  link = inner_html(item, "link")
	  title = inner_html(item, "title")
	  item_string << format_item(link, title)
	end
	
	@cache.save url, item_string if @cache
      end
      
      item_string
    end
    
    def get_items text
      items = text[/<item>.*<\/item>/mi]
      
      return [] unless items
      
      items.split(/<\/?item>/).reject { |item| /\A\s*\z/ =~ item }
    end
     
    def inner_html text, tag
      regex = Regexp.compile "<#{tag}>(.*)<\/#{tag}>?"

      matches = regex.match text
      return "" unless matches
      
      matches.captures[0]
    end
  end
end
