# encoding: UTF-8

require 'flannel/wrappable'
require 'flannel/feed_parser'
require 'flannel/file_cache'

require 'flannel/block_cutter'

module Flannel
  def self.quilt markup, params={}
    @cache = params[:cache]
    return nil unless markup
    
    cutter = Flannel::BlockCutter.new
    text_blocks = cutter.cut markup
    text_blocks.map { |block| block.to_h }.join("\n\n")
  end
  
  def self.cache
    @cache
  end
end