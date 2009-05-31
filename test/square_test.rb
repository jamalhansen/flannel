require 'test_helper'

class SquareTest < Test::Unit::TestCase
  should "accept lines with <<" do
    square = Flannel::Square.new
    square << "foo"
    assert_equal "foo", square.to_s
  end

  should "let you know if it's blank" do
    square = Flannel::Square.new
    assert square.blank?
    square << "foo"
    assert !square.blank?
  end

  should "return html" do
    square = Flannel::Square.new
    square << "foo"
    assert_equal "<p>foo</p>", square.to_h
  end

  context "on initialization" do
    should "accept a preformatted parameter" do
      square = Flannel::Square.new(:preformatted => true)
      assert square.preformatted
    end
  end

  context "When  block starts with one or more equals signs, Flannel" do
    should "convert one equals to a header one" do
      square = Flannel::Square.new
      markup = "= Some header"
      result = "<h1>Some header</h1>"

      square << markup
      assert_equal result, square.to_h
    end

    should "convert two equals to a header two" do
      square = Flannel::Square.new
      markup = "== Some header"
      result = "<h2>Some header</h2>"

      square << markup
      assert_equal result, square.to_h
    end

    should "strip convert underscores to pre tags" do
      markup = "_foo\n\n   bar\n_"
      square = Flannel::Square.new :preformatted => true

      square << "_foo"
      square << ""
      square << "   bar"
      square << "_"
      assert_equal "<pre>foo\n\n   bar</pre>", square.to_h
    end
  end
end
