require 'test_helper'
require 'stripe'

class SquareTest < Test::Unit::TestCase
  should "accept strings with <<" do
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
    square <<  "foo"
    assert_equal "<p>foo</p>", square.to_h
  end

  should "accept a style" do
    square = Flannel::Square.new
    square.style = :preformatted
    assert_equal :preformatted, square.style
  end

  context "style" do
    should "accept an optional style parameter" do
      square = Flannel::Square.new
      square.style = :foo
    end

    should "wrap in pre tags when preformatted" do
      square = Flannel::Square.new
      square.style = :preformatted
      square << "foo"
      assert_equal "<pre>foo</pre>", square.to_h
    end

    should "wrap in ul tags when unordered_list" do
      square = Flannel::Square.new
      square.style = :list
      square << "* foo"
      assert_equal "<ul><li>foo</li></ul>", square.to_h
    end
  end
end
