module Flannel
  class BaseBlock
    attr_reader :type, :id, :text, :parent_id, :attributes
    
    def initialize args
      header = args.shift
      @type = header.shift[1]
      @id = header.shift[1]
      @attributes = {}
      
      next_arg = header.shift
      while next_arg
        case next_arg[0]
        when :parent_id then
          @parent_id = next_arg[1]
        when :attribute_list then
          next_arg.shift
          next_arg.each do |attribute|
            @attributes[attribute[0]] = attribute[1]
          end
        end  
        next_arg = header.shift
      end
      
      @text = args.shift
    end
    
    def to_h
      html_formatter = Flannel::HtmlFormatter.new
      html_formatter.do(@text, @type, @id)
    end
  end
end