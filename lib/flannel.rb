require 'shears'

module Flannel
def self.quilt markup, params={}
    shears = Flannel::Shears.new params
    shears.cut markup
  end
end