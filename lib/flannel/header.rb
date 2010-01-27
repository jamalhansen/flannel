module Flannel
  class Header
    attr_reader :nodes
    
    def initialize text
      parse text
      @nodes = []
    end
    
    def identity
      @text.gsub(%r{[^\w\s\-]},'').gsub(%r{[^\w]},' ').split.join('-').downcase.to_sym
    end
    
    def to_s
      @text
    end
    
    def add_node node
      @nodes << node
    end 
    
    def parse text
      @text = text
    end
  end
end