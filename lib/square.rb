require 'wrappable'

module Flannel
  class Square
    include Flannel::Wrappable
    attr_accessor :style, :style_detail
    
    def initialize params={}
      @tags ={:preformatted => "pre", :list => "ul", :header => "h"}
      @stripes = []
    end

    def << text
      text = text.strip unless @style == :preformatted
      @stripes << Flannel::Stripe.stitch(text, :style=>@style)
    end

    def to_s
      @stripes.map { |stripe| stripe.weave }.join("\n")
    end

    def blank?
      @stripes.length == 0 || @stripes[0].empty?
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
        tag = tag + @style_detail.to_s if tag == "h"
      else
        tag = "p"
      end
      tag
    end
  end
end

