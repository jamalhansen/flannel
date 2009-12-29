require 'wrappable'
require 'feed_parser'

module Flannel
  class Stripe
    include Wrappable
    attr_reader :weave

    def self.stitch weave="", params={}
       Flannel::Stripe.new weave, params
    end

    def initialize weave="", params={}
      @weave = weave
      @wiki_link = params[:wiki_link]
      @style = params[:style]
    end
    
    def wiki_link topic
      if @wiki_link
        @wiki_link.call(permalink topic)
      else
        permalink topic[1..-2]
      end
    end

    def permalink topic
      require 'iconv'
      # thanks to ismasan http://snippets.dzone.com/posts/show/4457
      (Iconv.new('US-ASCII//TRANSLIT', 'utf-8').iconv topic).gsub(/[^\w\s\-]/,'').gsub(/[^\w]|[\_]/,' ').split.join('-').downcase
    end

    def empty?
      @weave == nil || @weave.strip == ""
    end

    def build_wiki_links
      return @weave if preformatted
      @weave.gsub(/-\w(.*)\w>/) { |match| %{<a href="#{wiki_link match}">#{match[1..-2]}</a>}}
    end

    def to_h
      if feed
	parser = Flannel::FeedParser.new
	parser.sub_feeds @weave
      else
	text = build_wiki_links
	markup text
      end
    end

    def preformatted
      @style == :preformatted
    end

    def list
      @style == :list
    end
    
    def feed
      @style == :feed
    end

    def markup text
      return html_escape text if preformatted

      tag = "li" if list
      wrap(text, tag)
     end

    def html_escape text
      require 'cgi'

      CGI::escapeHTML(text)
    end
  end
end
