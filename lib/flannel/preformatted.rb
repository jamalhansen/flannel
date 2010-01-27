module Flannel
  class Preformatted
    include Flannel::Node

    def initialize text
      parse text
    end
    
  end
end