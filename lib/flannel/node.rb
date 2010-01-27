module Flannel
  module Node
    attr_reader :identity, :parent, :text
    
    def parse text
      attr, @text = text.split("\n", 2)
      build_attributes attr
    end
    
    def build_attributes text
      @parent = text.to_sym
      @identity = @text.gsub(%r{[^\w\s\-]},'').gsub(%r{[^\w]},' ').split.join('-').downcase.to_sym
    end
  end
end