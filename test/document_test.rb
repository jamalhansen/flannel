require 'test_helper'

class DocumentTest < Test::Unit::TestCase
  context "cutting a simple file" do
    setup do
      @doc = Flannel::Document.new ["foo", "foo\nbar"]
    end

    should "remove header from content" do
      assert_equal 1, @doc.content.length
      assert_equal "bar", @doc.content[0].text
    end
    
    should "create headers from headers" do
      assert_equal 1, @doc.headers.length
      assert_equal "foo", @doc.headers[0].text
    end
    
    should "create page_index from content" do
      assert_equal 2, @doc.page_index.length
    end
    
    should "contain the header" do
      assert_equal "foo", @doc.page_index[:foo].text
    end
    
    should "contain the content" do
      assert_equal "bar", @doc.page_index[:bar].text  #this will probably not hold true
    end
    
    should "connect the paragraph to the header" do
      assert_equal 1, @doc.page_index[:foo].nodes.length
      assert_equal "bar", @doc.page_index[:foo].nodes[0].text
    end
  end
  
  context "generating the correct element" do
    should "default to paragraph" do
      doc = Flannel::Document.new ["foo", "foo\nbar"]
      assert_equal Flannel::Paragraph, doc.page_index[:foo].nodes[0].class
    end
    
    should "create p as paragraph" do
      doc = Flannel::Document.new ["foo", "p foo\n bar"]
      assert_equal Flannel::Paragraph, doc.page_index[:foo].nodes[0].class
    end
    
    should "create quote as blockquote" do
      doc = Flannel::Document.new ["foo", "quote foo\n bar"]
      assert_equal Flannel::Blockquote, doc.page_index[:foo].nodes[0].class
    end
    
    should "create code as code" do
      doc = Flannel::Document.new ["foo", "code foo\n bar"]
      assert_equal Flannel::Code, doc.page_index[:foo].nodes[0].class
    end
    
    should "create pre as preformatted" do
      doc = Flannel::Document.new ["foo", "pre foo\n bar"]
      assert_equal Flannel::Preformatted, doc.page_index[:foo].nodes[0].class
    end
  end
  
  context "header parsing" do
    setup do
      headers = "Header 1\nHeader 2\n  Header 2a\n\tHeader 2b\nHeader 3"
      @doc = Flannel::Document.new [headers]
    end
    
    should "generate 5 headers" do
      assert_equal 5, @doc.headers.length
    end
    
    should "generate header 1 with no nodes" do
      assert_equal "Header 1", @doc.headers[0].text
      assert_equal 0, @doc.headers[0].nodes.length
    end

    should "generate header 2 with 2 nodes" do
      assert_equal "Header 2", @doc.headers[1].text
      assert_equal 2, @doc.headers[1].nodes.length
    end
    
    should "generate header 3 with no nodes" do
      assert_equal "Header 3", @doc.headers[4].text
      assert_equal 0, @doc.headers[4].nodes.length
    end
  end
end