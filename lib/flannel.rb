require 'markup_to_html'

module Flannel
  def self.to_h markup
    service = Flannel::MarkupToHtml.new
    service.to_h markup
  end
end