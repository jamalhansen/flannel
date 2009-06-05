module Flannel
  module Wrappable
    def wrap content, tag
      if empty?(content) || empty?(tag)
        return content
      end

      content.strip! unless tag == "pre"

      "<#{tag}>#{content}</#{tag}>"
    end

    def empty? str
      str.nil? || str.strip == ""
    end
  end
end
