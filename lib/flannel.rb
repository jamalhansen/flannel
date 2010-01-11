require 'flannel/cutting_board'
require 'flannel/wrappable'
require 'flannel/square'
require 'flannel/shears'
require 'flannel/stripe'
require 'flannel/feed_parser'

module Flannel
  def self.quilt markup, params={}
    return nil unless markup
    shears = Flannel::CuttingBoard.new params
    shears.cut markup
  end
end