require 'flannel/cutting_board'
require 'flannel/wrappable'
require 'flannel/square'
require 'flannel/shears'
require 'flannel/stripe'
require 'flannel/feed_parser'
require 'flannel/file_cache'

require 'flannel/block_cutter'
require 'flannel/text_block'
require 'flannel/html_formatter'

module Flannel
  def self.quilt markup, params={}
    @@cache_params = params
    return nil unless markup
    shears = Flannel::CuttingBoard.new
    shears.cut markup
  end
  
  def self.cache_params
    @@cache_params
  end
end