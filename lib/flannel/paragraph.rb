module Flannel
  class Paragraph
    include Flannel::Node

    def initialize text
      parse text
    end
    
  end
end