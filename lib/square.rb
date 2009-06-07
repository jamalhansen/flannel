require 'wrappable'

module Flannel
  class Square
    include Flannel::Wrappable
    attr_accessor :style
    
    def initialize params={}
      @tags ={:preformatted => "pre", :list => "ul", :header_1 => "h1", :header_2 => "h2", :header_3 => "h3", :header_4 => "h4", :header_5 => "h5", :header_6 => "h6"}
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
      return wrap(output, find_tag)
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

