require 'flannel/html_transformable'

module Flannel
  
  # HtmlFormatter is responsible for formatting text blocks as html
  class HtmlFormatter
    include Flannel::HtmlTransformable
    
    def initialize
      @tags ={:preformatted => "pre", 
              :feed => "ul", 
              :list => "ul", 
              :dlist => "dl", 
              :header_one => "h1", #new style
              :header_two => "h2", 
              :header_three => "h3", 
              :header_four => "h4", 
              :header_five => "h5", 
              :header_six => "h6",
              :paragraph => "p",
              :blockquote => "blockquote"}
    end
    
    def do text, style, id=nil
      @text = text
      @style = style
      @id = id      
      
      build_html
    end

    def build_html
      case @style
	
      when :preformatted
        html =  html_escape @text
      when :feed
        html =  parse_feed @text
      when :image
        html =  create_img @text
      else
        html =  build_wiki_links @text
        html =  convert_external_links html
        
        if @style == :list
          html = format_list html
        end
        
        if @style == :dlist
          html =  format_dlist html
        end
      end
      
      wrap(html, @tags[@style], @id)
    end
  end
end