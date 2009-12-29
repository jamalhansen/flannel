require 'test_helper'

class ShearsTest < Test::Unit::TestCase
  context "basic behavior" do
    setup do
      @shears = Flannel::Shears.new
    end

    should "split a flannel document into squares based on blank lines" do
      markup = "foo\n\nbar"

      squares = @shears.cut markup
      assert_equal 2, squares.length
      assert_equal "foo", squares[0].to_s
      assert_equal "bar", squares[1].to_s
    end

    should "not split preformatted text based on blank lines" do
      markup = "_foo\n\nbar\n_"

      squares = @shears.cut markup
      assert_equal 1, squares.length
      assert_equal :preformatted, squares[0].style
    end


    should "separate preformatted blocks" do
      markup = "_foo\n_\n\n_bar\n_"

      squares = @shears.cut markup
      assert_equal 2, squares.length
      assert_equal :preformatted, squares[0].style
      assert_equal :preformatted, squares[1].style
    end

    should "strip preformatted markers when found" do
      markup = "_foo\n\nbar\n_"

      squares = @shears.cut markup
      assert_equal "foo\n\nbar",  squares[0].to_s
    end
    
    should "set square style to feed based on ampersand " do
      markup = "& http://www.example.com/rss"

      squares = @shears.cut markup
      assert_equal :feed, squares[0].style
    end
  end
end
