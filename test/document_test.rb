require 'test_helper'

class DocumentTest < Test::Unit::TestCase
  context "cutting a simple file" do
    setup do
      @doc = Flannel::Document.new ["foo", "foo\nbar"]
    end

    should "remove header from content" do
      assert_equal 1, @doc.content.length
      assert_equal "bar", @doc.content[0].to_s
    end
    
    should "create headers from headers" do
      assert_equal 1, @doc.headers.length
      assert_equal "foo", @doc.headers[0].to_s
    end
    
    should "create page_index from content" do
      assert_equal 2, @doc.page_index.length
    end
    
    should "contain the header" do
      assert_equal "foo", @doc.page_index[:foo].to_s
    end
    
    should "contain the content" do
      assert_equal "bar", @doc.page_index[:bar].to_s
    end
    
    should "connect the paragraph to the header" do
      assert_equal 1, @doc.page_index[:foo].nodes.length
      assert_equal "bar", @doc.page_index[:foo].nodes[0].to_s
    end
  end
end