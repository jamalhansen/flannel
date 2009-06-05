require 'shears'

module Flannel
  def self.to_h markup, params={}
    shears = Flannel::Shears.new params
    shears.to_h markup
  end
end