module Flannel
  class TextBlock
    attr_reader :style
    
    def initialize text
      @style, @text = strip_style_marker text
    end
    
    def to_s
      @text
    end
    
    def strip_style_marker text 
      case text[0]
      when '_'[0]
	[:preformatted, text[1..-1]]
      when '&'[0]
	[:feed, text[1..-1]]
      else
	[:paragraph, text]
      end
    end
  end
end