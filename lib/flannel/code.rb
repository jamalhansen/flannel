module Flannel
  class Code
    include Flannel::Node

    def initialize text
      parse text
    end
    
  end
end