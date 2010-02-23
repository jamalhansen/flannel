module Flannel
  module Wrappable
    def wrap content, tag, element_id=nil
      if empty_string?(content) || empty_string?(tag)
        return content
      end

      content.strip! unless tag == "pre"

      if element_id
        "<#{tag} id='#{element_id}'>#{content}</#{tag}>"
      else
        "<#{tag}>#{content}</#{tag}>"
      end
    end

    def empty_string? str
      str.nil? || str.strip == ""
    end
  end
end
