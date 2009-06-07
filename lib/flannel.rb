require 'quilter'

module Flannel
def self.quilt markup, params={}
    shears = Flannel::Quilter.new params
    shears.cut markup
  end
end