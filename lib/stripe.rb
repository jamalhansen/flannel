require 'wrappable'

module Flannel
  class Stripe
    include Wrappable
    attr_reader :thread

    def self.stitch params={}
       Flannel::Stripe.new params
    end

    def initialize params={}
      @thread = params[:thread]
      @wiki_link = params[:wiki_link]
    end
    
    def wiki_link topic
      @wiki_link.call(permalink topic)
    end

    def permalink topic
      require 'iconv'
      # thanks to ismasan http://snippets.dzone.com/posts/show/4457
      (Iconv.new('US-ASCII//TRANSLIT', 'utf-8').iconv topic).gsub(/[^\w\s\-\â€”]/,'').gsub(/[^\w]|[\_]/,' ').split.join('-').downcase
    end

    def empty?
      @thread == nil || @thread.strip == ""
    end

    def build_wiki_links
      @thread.gsub(/-(.*)>/) { |match| %{<a href="#{wiki_link match}">#{match[1..-2]}</a>}}
    end

    def to_h
      build_wiki_links
    end

    def trim_first
      Flannel::Stripe.stitch(:thread => @thread[1..-1], :wiki_link => @wiki_link)
    end
  end
end
