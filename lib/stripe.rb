require 'wrappable'

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
      return topic unless @wiki_link
      
      @wiki_link.call(permalink topic)
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
      @weave.gsub(/-(.*)>/) { |match| %{<a href="#{wiki_link match}">#{match[1..-2]}</a>}}
    end

    def to_h
      text = build_wiki_links
      markup text
    end

    def preformatted
      @style == :preformatted
    end

    def list
      @style == :list
    end

    def header
      /^header/ =~ @style.to_s
    end


    def clean text
      if list || header
        parts = text.split(' ', 2)
        return parts[1].strip
      end

      text
    end

    def markup text
      return text if preformatted

      tag = "li" if list
      wrap(clean(text), tag)
    end
  end
end
