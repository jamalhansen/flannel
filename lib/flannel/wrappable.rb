module Flannel
  module Wrappable
    def wrap content, tag
      if empty_string?(content) || empty_string?(tag)
        return content
      end

      content.strip! unless tag == "pre"

      "<#{tag}>#{content}</#{tag}>"
    end

    def empty_string? str
      str.nil? || str.strip == ""
    end
  end
end
