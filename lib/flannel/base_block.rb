require 'flannel/html_formatter'

module Flannel
  class BaseBlock
    attr_reader :type, :id, :text, :parent_id, :attributes
    
    def initialize block
      form = block[0]
      
      if form == :block
        create_from_list block[1]
      else
        @text = block[1]
        @type = :paragraph
      end
      
      strip_text
    end
    
    def create_from_list list
      header = list.shift
      @type = header.shift[1]
      @id = header.shift[1]
      @attributes = {}
      
      next_item = header.shift
      while next_item
        case next_item[0]
        when :parent_id then
          @parent_id = next_item[1]
        when :attribute_list then
          next_item.shift
          next_item.each do |attribute|
            @attributes[attribute[0]] = attribute[1]
          end
        end  
        next_item = header.shift
      end
      
      @text = list.shift
    end
    
    def to_h
      html_formatter = Flannel::HtmlFormatter.new
      html_formatter.do(@text, @type, @id)
    end
    
    def strip_text
      return if @type == :preformatted
      return unless @text
      
      @text = @text.strip
    end
  end
end