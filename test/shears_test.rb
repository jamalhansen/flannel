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
    assert_equal :preformatted, squares[0].style
  end

  should "strip preformatted markers when found" do
    markup = "_foo\n\nbar\n_"
    shears = Flannel::Shears.new

    squares = shears.cut_into_squares markup
    assert_equal "foo\n\nbar",  squares[0].to_s
  end

  should "strip and convert underscores to pre tags" do
    markup = "_foo\n\n   bar\n_"
    shears = Flannel::Shears.new
    assert_equal "<pre>foo\n\n   bar</pre>", shears.cut(markup)
  end

  should "preformat text when both start and end line have the markers" do
    markup = "_foo\n\n_   bar"
    shears = Flannel::Shears.new
    assert_equal "<pre>foo\n\n   bar</pre>", shears.cut(markup)
  end

  context "When building wiki links, Square" do
    should "not replace in preformatted text" do
      shears = Flannel::Shears.new
      result = shears.cut("_4 - 2 > 2 - 2\n_")
      assert_equal '<pre>4 - 2 > 2 - 2</pre>', result
    end

    #html escape preformatted
  end

  context "When block starts with one or more equals signs, it" do
    should "convert one equals to a header one" do
      shears = Flannel::Shears.new
      markup = "= Some header"
      result = "<h1>Some header</h1>"

      assert_equal result, shears.cut(markup)
    end

    should "convert two equals to a header two" do
      shears = Flannel::Shears.new
      markup = "== Some header"
      result = "<h2>Some header</h2>"

      assert_equal result, shears.cut(markup)
    end
  end
end
