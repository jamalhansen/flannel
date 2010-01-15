
module Flannel
  class CuttingBoard
    def initialize params={}
      @params = params
    end

    def cut markup
      shears = Flannel::Shears.new @params
      squares = shears.cut markup
      squares.map { |square| square.to_h }.join("\n\n")
    end
  end
end
