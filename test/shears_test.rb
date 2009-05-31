require 'test_helper'

class ShearsTest < Test::Unit::TestCase
  should "split a flannel document into squares based on blank lines" do
    markup = "foo\n\nbar"
    shears = Flannel::Shears.new

    squares = shears.cut_into_squares markup
    assert_equal 2, squares.length
    assert_equal "foo", squares[0].to_s
    assert_equal "bar", squares[1].to_s
  end

  should "not split preformatted text based on blank lines" do
    markup = "_foo\n\nbar\n_"
    shears = Flannel::Shears.new

    squares = shears.cut_into_squares markup
    assert_equal 1, squares.length
    assert squares[0].preformatted
  end
end
