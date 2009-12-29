require 'hpricot'
require 'open-uri'

module Flannel
  class FeedParser
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
      open(url)
    end
    
    def format_item(link, title)
      "  <li>\n    <a href='#{link}'>#{title}</a>\n  </li>\n"
    end

    def get_news url
      item_string = ""
      #begin
	doc = Hpricot.XML(get_document(url))

	(doc/"item").each do |item|
	  link = (item/"link").inner_html
	  title = (item/"title").inner_html
	  item_string << format_item(link, title)
	end
	
	item_string
      #rescue
      #  "Error retrieving data."
      #end
    end
  end
end
