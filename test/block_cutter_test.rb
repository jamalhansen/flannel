require 'test_helper'

class BlockCutterTest < Test::Unit::TestCase
  context "basic behavior" do
    setup do
      @block_cutter = Flannel::BlockCutter.new
    end

    should "split a flannel document into blocks based on block_headers" do
      markup = ":paragraph bar: some text\n:paragraph baz: some more text"

      blocks = @block_cutter.cut markup
      assert_equal 2, blocks.length
 
      assert_equal :paragraph, blocks[0].type
      assert_equal "bar", blocks[0].id
      assert_equal :paragraph, blocks[1].type
      assert_equal "baz", blocks[1].id

    end
    
    should "accept a block without an id" do
      markup = ":paragraph: some text"

      blocks = @block_cutter.cut markup
      assert_equal 1, blocks.length
 
      assert_equal :paragraph, blocks[0].type
      assert_nil blocks[0].id
    end

    should "not split preformatted text based on blank lines" do
      markup = ":preformatted my_preformatted:\n foo\n\nbar\n"

      blocks = @block_cutter.cut markup
      assert_equal 1, blocks.length
      assert_equal :preformatted, blocks[0].type
      assert_equal "my_preformatted", blocks[0].id
      assert_equal " foo\n\nbar\n", blocks[0].text
    end


    should "separate preformatted blocks" do
      markup = ":preformatted one:foo\n:preformatted two:\nbar\n"

      blocks = @block_cutter.cut markup
      assert_equal 2, blocks.length
      assert_equal :preformatted, blocks[0].type
      assert_equal :preformatted, blocks[1].type
    end

    should "strip preformatted markers when found" do
      markup = ":preformatted foo:foo\n\nbar\n"

      blocks = @block_cutter.cut markup
      assert_equal "foo\n\nbar\n",  blocks[0].text
    end
    
    should "set square style to feed based on full tag " do
      markup = ":feed: wonki\nhttp://www.example.com/rss"

      blocks = @block_cutter.cut markup
      assert_equal :feed, blocks[0].type
    end
    
    should "parse a paragraph with a simple wiki link" do
      markup = ":paragraph:\n-ravioli>"

      blocks = @block_cutter.cut markup
      assert_equal :paragraph, blocks[0].type
      assert_nil blocks[0].id
      assert_equal '-ravioli>', blocks[0].text
    end
    
    should "parse a simple paragraph" do
      markup = ":paragraph:bar bar\n"

      blocks = @block_cutter.cut markup
      assert_equal :paragraph, blocks[0].type
      assert_nil blocks[0].id
      assert_equal "bar bar", blocks[0].text
    end
  end
end
