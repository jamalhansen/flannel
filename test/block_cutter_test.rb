require 'test_helper'

class BlockCutterTest < Test::Unit::TestCase
  context "basic behavior" do
    setup do
      @block_cutter = Flannel::BlockCutter.new
    end

    should "split a flannel document into blocks based on block_headers" do
      markup = ":paragraph bar\n some text\n:paragraph baz\n some more text"

      blocks = @block_cutter.cut markup
      assert_equal 2, blocks.length
 
      assert_equal :paragraph, blocks[0].type
      assert_equal "bar", blocks[0].id
      assert_equal :paragraph, blocks[1].type
      assert_equal "baz", blocks[1].id

    end

    should "not split preformatted text based on blank lines" do
      markup = ":preformatted my_preformatted\n foo\n\nbar\n"

      blocks = @block_cutter.cut markup
      assert_equal 1, blocks.length
      assert_equal :preformatted, blocks[0].type
      assert_equal "my_preformatted", blocks[0].id
      assert_equal "foo\n\nbar", blocks[0].text
    end


    should "separate preformatted blocks" do
      markup = ":preformatted one\nfoo\n:preformatted two\nbar\n"

      blocks = @block_cutter.cut markup
      assert_equal 2, blocks.length
      assert_equal :preformatted, blocks[0].type
      assert_equal :preformatted, blocks[1].type
    end

    should "strip preformatted markers when found" do
      markup = ":preformatted foo\nfoo\n\nbar\n"

      blocks = @block_cutter.cut markup
      assert_equal "foo\n\nbar",  blocks[0].text
    end
    
    should "set square style to feed based on full tag " do
      markup = ":feed wonki\nhttp://www.example.com/rss"

      blocks = @block_cutter.cut markup
      assert_equal :feed, blocks[0].type
    end
  end
end
