require 'shears'


module Flannel
  class Quilter
    def initialize params={}
      @wiki_link= params[:wiki_link]
    end

    def cut markup
      shears = Flannel::Shears.new
      squares = shears.cut markup
      squares.map { |square| square.to_h }.join("\n\n")
    end
  end
end
