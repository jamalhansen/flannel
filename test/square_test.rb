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

  context "When block starts with one or more equals signs, it" do
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

  context "When cleaning preformatted text" do
    should "remove rows with only an underscore and whitespace" do
      lines = ["_ ", "foo"]
      square = Flannel::Square.new

      new_lines = square.trim_underscore(lines, 0)
      assert_equal 1, new_lines.length
      assert_equal "foo", new_lines[0]
    end

    should "only remove underscore when line contains non-whitespace and trailing underscore" do
      lines = ["_foo", "_"]
      square = Flannel::Square.new

      new_lines = square.trim_underscore(lines, 0)
      new_lines = square.trim_underscore(new_lines, 1)
      assert_equal 1, new_lines.length
      assert_equal "foo", new_lines[0]
    end

    should "only remove underscore when line contains non-whiespace and leading underscore" do
      lines = ["_", "_foo"]
      square = Flannel::Square.new

      new_lines = square.trim_underscore(lines, 0)
      new_lines = square.trim_underscore(new_lines, 0)
      assert_equal 1, new_lines.length
      assert_equal "foo", new_lines[0]
    end

    should "trim first and last lines" do
      lines = ["_ ", "foo", "_"]
      square = Flannel::Square.new :preformatted => true

      lines.each do |line|
        square << line
      end

      new_lines = square.clean_stray_underscores
      assert_equal 1, new_lines.length
      assert_equal "foo", new_lines[0]
    end
  end

  context "When building wiki links, Square" do
    should "build wiki links" do
      wiki_link = lambda { |keyword| "http://www.example.com/foo/#{keyword}/"}
      square = Flannel::Square.new :wiki_link => wiki_link

      assert_equal "http://www.example.com/foo/bar/", square.wiki_link("bar")
    end

    should "build wiki links based on a lambda" do
      wiki_link = lambda { |keyword| "http://www.rubyyot.com/foo/#{keyword}/"}
      square = Flannel::Square.new :wiki_link => wiki_link

      assert_equal "http://www.rubyyot.com/foo/cheese/", square.wiki_link("cheese")
    end

    should "should make topics into permalinks" do
      square = Flannel::Square.new
      assert_equal "get-the-box", square.permalink("get the box")
    end

    should "permalink topics when making wiki links" do
      wiki_link = lambda { |keyword| "http://www.example.com/foo/#{keyword}/"}
      square = Flannel::Square.new :wiki_link => wiki_link

      assert_equal "http://www.example.com/foo/cheese-tastes-good/", square.wiki_link("cheese tastes good")
    end

    should "find and replace wiki link markup" do
      wiki_link = lambda { |keyword| "../foo/#{keyword}"}
      square = Flannel::Square.new :wiki_link => wiki_link

      square << "the -roof is on fire>"
      assert_equal '<p>the <a href="../foo/roof-is-on-fire">roof is on fire</a></p>', square.to_h
    end

    should "not replace in preformatted text" do
      wiki_link = lambda { |keyword| "../foo/#{keyword}"}
      square = Flannel::Square.new :wiki_link => wiki_link, :preformatted => true

      square << "_4 - 2 > 2 - 2"
      square << "_"
      assert_equal '<pre>4 - 2 > 2 - 2</pre>', square.to_h
    end

    #html escape preformatted
  end
end
