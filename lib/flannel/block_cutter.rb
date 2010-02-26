module Flannel
  class BlockCutter
    def cut markup
      parser = BlockParser.new
      blocks = parser.parse(markup).content.map { |block| form_blocks block }
    end
    
    def form_blocks block
      Flannel::BaseBlock.new(block)
    end
    
    def split_into_blocks markup
      if is_preformatted markup
        markup
      else
        markup.split(/\n\s*?\n/).map { |s| s.strip }
      end
    end
    
    def split_preformatted_blocks markup
      markup.split(/^(_(?=\n\n)|(?=_))/).map { |s| s.strip }.reject { |s| is_invalid_block s}
    end
    
    def convert_to_text_blocks pieces
      pieces.map{ |piece| Flannel::TextBlock.new piece }
    end
    
    def is_invalid_block s
      s == "" || s == "_" 
    end
    
    def is_preformatted markup
      markup[0] == '_'[0]
    end
  end
end