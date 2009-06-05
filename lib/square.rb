require 'wrappable'

module Flannel
  class Square
    include Flannel::Wrappable
    attr_accessor :preformatted
    
    def initialize params={}
      @preformatted = params[:preformatted] == true
      @stripes = []
    end

    def << stripe
      @stripes << stripe
    end

    def to_s
      @stripes.map { |stripe| stripe.thread }.join("\n")
    end

    def blank?
      @stripes.length == 0 || @stripes[0].empty?
    end

    def to_h
      if @preformatted
        clean_stray_underscores
        html = @stripes.map { |stripe| stripe.thread }.join("\n")
        html = wrap html, "pre"
      else
        @post_wrap = nil
        html = @stripes.map { |stripe| markup(stripe.to_h) }.join("\n")
        html = wrap html, @post_wrap
      end
    end

    def markup text
      parts = text.match(/^(\W+) (.*)/)

      if parts
        case parts[1][0]
        when 42  # * - list
          text = text[1..-1].strip
          tag = "li"
          @post_wrap = "ul"
        when 61  # = - header
          tag = "h#{parts[1].length}"
          text = parts[2]
        end
      else
        tag = "p"
      end

      wrap text, tag
    end

    def clean_stray_underscores
      @stripes = trim_underscore @stripes, 0
      @stripes = trim_underscore @stripes, @stripes.length-1
    end

    def trim_underscore list, line_num
      stripe = list[line_num].trim_first

      if stripe.empty?
        list.delete_at line_num     #remove line if it's just an underscore
      else
        list[line_num] = stripe #remove underscore
      end
      list
    end
  end
end

