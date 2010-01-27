module Flannel
  class Blockquote
    include Flannel::Node
    
    def initialize text
      parse text
    end
    
  end
end