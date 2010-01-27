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
end