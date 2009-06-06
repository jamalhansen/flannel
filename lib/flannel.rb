require 'shears'

module Flannel
  def self.to_h markup, params={}
    shears = Flannel::Shears.new params
    shears.cut markup
  end
end