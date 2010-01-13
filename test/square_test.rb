require 'test_helper'

class SquareTest < Test::Unit::TestCase
  context "basic behavior" do
    setup do
      @square = Flannel::Square.new
    end

    should "accept strings with <<" do
      @square << "foo"
      assert_equal "foo", @square.to_s
    end

    should "be blank when there are no stripes" do
      assert @square.blank?
      @square << "foo"
      assert !@square.blank?
    end

    should "be blank when the first stripe is an empty string" do
      @square <<  ""
      assert @square.blank?
    end

    should "be blank when the first stripe is whitespace" do
      @square <<  "  "
      assert @square.blank?
    end

    should "be blank when the all stripes are empty strings" do
      @square <<  ""
      @square <<  ""
      @square <<  ""
      assert @square.blank?
    end

    should "be blank when the all stripes are whitespace" do
      @square <<  " "
      @square <<  " "
      @square <<  ""
      assert @square.blank?
    end

    should "not be blank when a stripe is not blank" do
      @square <<  " "
      @square <<  " "
      @square <<  "foo"
      assert !@square.blank?
    end

    should "return html" do
      @square <<  "foo"
      assert_equal "<p>foo</p>", @square.to_h
    end

    should "accept a style" do
      @square.style = :preformatted
      assert_equal :preformatted, @square.style
    end
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
      square << "foo"
      assert_equal "<ul><li>foo</li></ul>", square.to_h
    end
  end

  context "external links" do
    should "convert [|] pattern to an external link" do
      square = Flannel::Square.new
      square << "yadda [yadda|http://example.com] yadda"
      assert_equal '<p>yadda <a href="http://example.com" target="_blank">yadda</a> yadda</p>', square.to_h
    end

    should "add http:// to external links" do
      square = Flannel::Square.new
      square << "yadda [yadda|example.com] yadda"
      assert_equal '<p>yadda <a href="http://example.com" target="_blank">yadda</a> yadda</p>', square.to_h
    end

    should "add create title if provided to external links" do
      square = Flannel::Square.new
      square << "yadda [yadda|example.com|My title] yadda"
      assert_equal '<p>yadda <a href="http://example.com" title="My title" target="_blank">yadda</a> yadda</p>', square.to_h
    end
  end
end
