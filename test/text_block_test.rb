require 'test_helper'

class TextBlockTest < Test::Unit::TestCase
  context "basic behavior" do
    should "return html" do
      text_block = Flannel::TextBlock.new "foo"
      assert_equal "<p>foo</p>", text_block.to_h
    end
  end

  context "style" do
    should "recognize preformatted" do
      text_block = Flannel::TextBlock.new "_foo"
      assert_equal :preformatted, text_block.style
    end
    
    should "recognize paragraph" do
      text_block = Flannel::TextBlock.new "foo"
      assert_equal :paragraph, text_block.style
    end
    
    should "recognize list" do
      text_block = Flannel::TextBlock.new "* foo/n* bar/n* baz"
      assert_equal :list, text_block.style
    end
    
    should "recognize feed" do
      text_block = Flannel::TextBlock.new "& http://foo.example.com"
      assert_equal :feed, text_block.style
    end
    
    should "recognize header" do
      text_block = Flannel::TextBlock.new "====My Header"
      assert_equal :header_4, text_block.style
    end
    
    should "wrap in pre tags when preformatted" do
      text_block = Flannel::TextBlock.new "_foo"
      assert_equal "<pre>foo</pre>", text_block.to_h
    end

    should "wrap in ul tags when unordered_list" do
      text_block =  Flannel::TextBlock.new "* foo"
      assert_equal "<ul><li>foo</li></ul>", text_block.to_h
    end
  end

  context "external links" do
    should "convert [|] pattern to an external link" do
      text_block = Flannel::TextBlock.new "yadda [yadda|http://example.com] yadda"
      assert_equal '<p>yadda <a href="http://example.com" target="_blank">yadda</a> yadda</p>', text_block.to_h
    end

    should "add http:// to external links" do
      text_block = Flannel::TextBlock.new "yadda [yadda|example.com] yadda"
      assert_equal '<p>yadda <a href="http://example.com" target="_blank">yadda</a> yadda</p>', text_block.to_h
    end

    should "add create title if provided to external links" do
      text_block = Flannel::TextBlock.new "yadda [yadda|example.com|My title] yadda"
      assert_equal '<p>yadda <a href="http://example.com" title="My title" target="_blank">yadda</a> yadda</p>', text_block.to_h
    end
  end
end
