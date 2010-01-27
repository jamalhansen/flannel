require 'flannel/document'

module Flannel
  class Blade
    def cut text
      doc = Flannel::Document.new text.split(/^\^/).map { |s| s.strip}
    end
  end
end