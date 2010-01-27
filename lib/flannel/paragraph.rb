module Flannel
  class Paragraph

    def initialize text
      parse text
    end
    
    def identity
      @text.to_sym
    end
    
    def to_s
      @text
    end
    
    def parent_node
      @parent
    end
    
    def parse text
      header, @text = text.split("\n", 2)
      get_attributes header
    end
    
    def get_attributes text
      @parent = text.to_sym
    end
  end
end