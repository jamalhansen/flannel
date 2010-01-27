require 'flannel/code'
require 'flannel/preformatted'
require 'flannel/paragraph'
require 'flannel/blockquote'
require 'flannel/header'

module Flannel
  class Document
    attr_reader :headers, :content, :page_index
    
    def initialize content=[]
      @page_index = {}
      @headers = []
      @content = []
      build_doc content
    end
    
    private
      def build_doc content
	headers = content.shift
	
	build_headers headers
	add_content content
      end
      
      def build_headers text
	headers = text.split("\n")
	headers.each do |header_text|
	  header = Flannel::Header.new(header_text)
	  index header
	  @headers << header
	end
      end
      
      def add_content content
	content.each do |text|
	  element = get_element(text)
	  index element
	  @page_index[element.parent].add_node(element)
	  @content << element
	end
      end
      
      def index obj
	@page_index.store(obj.identity, obj)
      end
      
      def get_element text
	type, content = text.split(" ", 2)
	known_types = ["p", "quote", "code", "pre"]
	klass = [Flannel::Paragraph, Flannel::Blockquote, Flannel::Code, Flannel::Preformatted]
	
	return Flannel::Paragraph.new(text) unless known_types.include? type
	
	klass[known_types.index(type)].new(content)
      end
  end
end