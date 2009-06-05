require 'test_helper'
require 'stripe'

class SquareTest < Test::Unit::TestCase
  should "accept stripes with <<" do
    square = Flannel::Square.new
    square << Flannel::Stripe.stitch(:thread => "foo")
    assert_equal "foo", square.to_s
  end

  should "let you know if it's blank" do
    square = Flannel::Square.new
    assert square.blank?
    square << Flannel::Stripe.new(:thread =>"foo")
    assert !square.blank?
  end

  should "return html" do
    square = Flannel::Square.new
    square << Flannel::Stripe.new(:thread =>"foo")
    assert_equal "<p>foo</p>", square.to_h
  end

  context "on initialization" do
    should "accept a preformatted parameter" do
      square = Flannel::Square.new(:preformatted => true)
      assert square.preformatted
    end
  end

  context "When block starts with one or more equals signs, it" do
    should "convert one equals to a header one" do
      square = Flannel::Square.new
      markup = Flannel::Stripe.new(:thread =>"= Some header")
      result = "<h1>Some header</h1>"

      square << markup
      assert_equal result, square.to_h
    end

    should "convert two equals to a header two" do
      square = Flannel::Square.new
      markup = Flannel::Stripe.stitch(:thread =>"== Some header")
      result = "<h2>Some header</h2>"

      square << markup
      assert_equal result, square.to_h
    end

    should "strip convert underscores to pre tags" do
      markup = "_foo\n\n   bar\n_"
      square = Flannel::Square.new :preformatted => true

      square << Flannel::Stripe.stitch(:thread =>"_foo")
      square << Flannel::Stripe.stitch(:thread =>"")
      square << Flannel::Stripe.stitch(:thread =>"   bar")
      square << Flannel::Stripe.stitch(:thread =>"_")
      assert_equal "<pre>foo\n\n   bar</pre>", square.to_h
    end
  end

  context "When cleaning preformatted text" do
    should "remove rows with only an underscore and whitespace" do
      lines = [Flannel::Stripe.stitch(:thread => "_ "), Flannel::Stripe.stitch(:thread =>"foo")]
      square = Flannel::Square.new

      new_lines = square.trim_underscore(lines, 0)
      assert_equal 1, new_lines.length
      assert_equal "foo", new_lines[0].thread
    end

    should "only remove underscore when line contains non-whitespace and trailing underscore" do
      lines = [Flannel::Stripe.stitch(:thread =>"_foo"), Flannel::Stripe.stitch(:thread =>"_")]
      square = Flannel::Square.new

      new_lines = square.trim_underscore(lines, 0)
      new_lines = square.trim_underscore(new_lines, 1)
      assert_equal 1, new_lines.length
      assert_equal "foo", new_lines[0].thread
    end

    should "only remove underscore when line contains non-whiespace and leading underscore" do
      lines = [Flannel::Stripe.stitch(:thread =>"_"), Flannel::Stripe.new(:thread =>"_foo")]
      square = Flannel::Square.new

      new_lines = square.trim_underscore(lines, 0)
      new_lines = square.trim_underscore(new_lines, 0)
      assert_equal 1, new_lines.length
      assert_equal "foo", new_lines[0].thread
    end

    should "trim first and last lines" do
      lines = ["_ ", "foo", "_"]
      square = Flannel::Square.new :preformatted => true

      lines.each do |line|
        square << Flannel::Stripe.stitch(:thread => line)
      end

      new_lines = square.clean_stray_underscores
      assert_equal 1, new_lines.length
      assert_equal "foo", new_lines[0].thread
    end
  end

  context "When building wiki links, Square" do
    should "not replace in preformatted text" do
      wiki_link = lambda { |keyword| "../foo/#{keyword}"}
      square = Flannel::Square.new :wiki_link => wiki_link, :preformatted => true

      square << Flannel::Stripe.stitch(:thread =>"_4 - 2 > 2 - 2")
      square << Flannel::Stripe.stitch(:thread =>"_")
      assert_equal '<pre>4 - 2 > 2 - 2</pre>', square.to_h
    end

    #html escape preformatted
  end
end
