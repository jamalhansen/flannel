module Flannel
  class Header
    attr_reader :nodes, :text, :identity
    
    def initialize text
      parse text
      @nodes = []
    end
    
    def add_node node
      @nodes << node
    end 
    
    def parse text
      @text = text
      @identity = @text.gsub(%r{[^\w\s\-]},'').gsub(%r{[^\w]},' ').split.join('-').downcase.to_sym
    end
  end
end