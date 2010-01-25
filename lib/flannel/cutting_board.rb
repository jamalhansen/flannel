
module Flannel
  class CuttingBoard
    def cut markup
      cutter = Flannel::BlockCutter.new
      text_blocks = cutter.cut markup
      text_blocks.map { |text| text.to_h }.join("\n\n")
    end
  end
end
