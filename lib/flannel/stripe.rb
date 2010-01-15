
module Flannel
  class Stripe
    include Wrappable
    attr_reader :weave

    def self.stitch weave="", params={}
       Flannel::Stripe.new weave, params
    end

    def initialize weave="", params={}
      @weave = weave
      @params = params
    end
    
    def wiki_link topic
      if @params[:wiki_link]
        @params[:wiki_link].call(permalink topic)
      else
        permalink topic[1..-2]
      end
    end

    def permalink topic
      topic.gsub(%r{[^/\w\s\-]},'').gsub(%r{[^\w/]|[\_]},' ').split.join('-').downcase
    end

    def empty?
      @weave == nil || @weave.strip == ""
    end

    def build_wiki_links
      return @weave if preformatted
      @weave.gsub(/-\w(.*?)\w>/) { |match| %{<a href="#{wiki_link match}">#{format_link_display(match)}</a>}}
    end
    
    def format_link_display text
      text[1..-2].split("/").last
    end

    def to_h
      if feed
	parser = Flannel::FeedParser.new @params
	parser.sub_feeds @weave
      else
	text = build_wiki_links
	markup text
      end
    end

    def preformatted
      @params[:style] == :preformatted
    end

    def list
      @params[:style] == :list
    end
    
    def feed
      @params[:style] == :feed
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
