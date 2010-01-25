module Flannel
  class TextBlock
    attr_reader :style
    
    def initialize text
      set_style_marker text
    end
    
    def to_s
      @text
    end
    
    def to_h
      html_formatter = Flannel::HtmlFormatter.new
      html_formatter.do(@text, @style)
    end
    
    def set_style_marker text 
      case text[0]
      when '_'[0]		#preformatted
	@style = :preformatted
	@text =  text[1..-1]
      when '&'[0]		#feed
	@style = :feed
	@text =  text[1..-1]
      when '*'[0]		#list
	@style = :list
	@text = text
      when '='[0]		#header
	match = text.match /^(=+)/
	weight = match.captures[0].length
	
	@style = "header_#{weight}".to_sym
	@text =  text[weight..-1]
      else			#other
	@style = :paragraph
	@text =  text
      end
    end
  end
end