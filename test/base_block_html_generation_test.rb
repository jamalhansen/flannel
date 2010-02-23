require 'test_helper'

class HtmlGenerationTest < Test::Unit::TestCase
  context "basic behavior" do
    should "wrap in pre tags when preformatted" do
      block = Flannel::BaseBlock.new [[[:block_type, :preformatted], [:block_id, "some-id"], [:attribute_list]], "foo"]
      assert_equal "<pre id='some-id'>foo</pre>", block.to_h
    end

    should "wrap in ul tags when unordered_list" do
      block =  Flannel::BaseBlock.new [[[:block_type, :list], [:block_id, "some-id"], [:attribute_list]], "foo"]
      assert_equal "<ul id='some-id'><li>foo</li></ul>", block.to_h
    end

    should "convert [|] pattern to an external link" do
      block = Flannel::BaseBlock.new [[[:block_type, :paragraph], [:block_id, "some-id"], [:attribute_list]], "yadda [yadda|http://example.com] yadda"]
      assert_equal %q{<p id='some-id'>yadda <a href="http://example.com" target="_blank">yadda</a> yadda</p>}, block.to_h
    end

    should "add http:// to external links" do
      block = Flannel::BaseBlock.new [[[:block_type, :paragraph], [:block_id, "some-id"], [:attribute_list]], "yadda [yadda|example.com] yadda"]
      assert_equal %q{<p id='some-id'>yadda <a href="http://example.com" target="_blank">yadda</a> yadda</p>}, block.to_h
    end

    should "add create title if provided to external links" do
      block = Flannel::BaseBlock.new  [[[:block_type, :paragraph], [:block_id, "some-id"], [:attribute_list]], "yadda [yadda|example.com|My title] yadda"]
      assert_equal %q{<p id='some-id'>yadda <a href="http://example.com" title="My title" target="_blank">yadda</a> yadda</p>}, block.to_h
    end
  end
end
