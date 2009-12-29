require 'wrappable'

module Flannel
  class Square
    include Flannel::Wrappable
    attr_accessor :style
    
    def initialize params={}
      @tags ={:preformatted => "pre", :feed => "ul", :list => "ul", :header_1 => "h1", :header_2 => "h2", :header_3 => "h3", :header_4 => "h4", :header_5 => "h5", :header_6 => "h6"}
      @stripes = []
      @style = :paragraph
    end

    def << text
      text = text.strip unless @style == :preformatted
      @stripes << Flannel::Stripe.stitch(text, :style=>@style)
    end

    def to_s
      @stripes.map { |stripe| stripe.weave }.join("\n")
    end

    def blank?
      (@stripes.length == 0 || all_stripes_blank)
    end

    def populated?
      !blank?
    end

    def all_stripes_blank
      @stripes.each do |stripe|
        return false if !stripe.empty?
      end

      return true
    end

    def to_h
      @post_wrap = nil
      lines = @stripes.map { |stripe| stripe.to_h }

      quilt lines
    end
    
    def quilt lines
      output = lines.join("\n")
      output = convert_external_links output
      return wrap(output, find_tag)
    end

    def preformatted
      @style == :preformatted
    end

    def convert_external_links text
      return text if preformatted
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

    def find_tag
      if @style && @tags.has_key?(@style)
        tag = @tags[@style]
      else
        tag = "p"
      end
      tag
    end
  end
end

