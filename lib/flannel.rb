require 'shears'

module Flannel
  def self.to_h markup
    service = Flannel::Shears.new
    service.to_h markup
  end
end