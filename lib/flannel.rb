require 'cutting_board'

module Flannel
  def self.quilt markup, params={}
    return nil unless markup
    shears = Flannel::CuttingBoard.new params
    shears.cut markup
  end
end