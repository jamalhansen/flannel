module Flannel
  class BlockCutter
    def cut markup
      pieces = split_preformatted_blocks(markup)
      pieces = pieces.map { |part| split_into_blocks(part) }
      pieces.flatten!
      convert_to_squares pieces
    end
    
    def split_into_blocks markup
      if is_preformatted markup
	markup
      else
        markup.split(/\n\s*?\n/).map { |s| s.chomp }
      end
    end
    
    def split_preformatted_blocks markup
      markup.split(/^(?=_)|_$/).reject { |s| is_invalid_block s}.map { |s| s.chomp }
    end
    
    def convert_to_squares pieces
      pieces.map{ |piece| Flannel::TextBlock.new piece }
    end
    
    def is_invalid_block s
      result = (s =~ /^_?\s*$/)
      result == 0
    end
    
    def is_preformatted markup
      markup[0] == '_'[0]
    end
  end
end