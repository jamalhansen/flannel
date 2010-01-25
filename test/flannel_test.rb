require 'test_helper'

class FlannelTest < Test::Unit::TestCase
  should "wrap functionality up in a neat package" do
    markup = "== Foo\n\n* Bar"
    assert_equal "<h2>Foo</h2>\n\n<ul><li>Bar</li></ul>", Flannel.quilt(markup)
  end

  should "return nil if text is nil" do
    assert_nil Flannel.quilt(nil)
  end

  should "parse paragraphs correctly" do
    input = "\nThis is paragraph one.\n\nThis is paragraph two.\n\nThis is paragraph three. Watchout for the end of file.\n"
    output = "<p>This is paragraph one.</p>\n\n<p>This is paragraph two.</p>\n\n<p>This is paragraph three. Watchout for the end of file.</p>"
    assert_equal output, Flannel.quilt(input)
  end
  
  context "basic behavior" do
    should "strip and convert underscores to pre tags" do
      markup = "_foo\n\n   bar\n_"
      assert_equal "<pre>foo\n\n   bar</pre>",  Flannel.quilt(markup)
    end

    should "not replace in preformatted text" do
      markup = "_4 - 2 > 2 - 2\n_"
      assert_equal '<pre>4 - 2 &gt; 2 - 2</pre>',  Flannel.quilt(markup)
    end
  end

  context "When block starts with one or more equals signs, it" do
    should "convert one equals to a header one" do
      markup = "= Some header"
      result = "<h1>Some header</h1>"

      assert_equal result,  Flannel.quilt(markup)
    end

    should "convert two equals to a header two" do
      markup = "== Some header"
      result = "<h2>Some header</h2>"

      assert_equal result,  Flannel.quilt(markup)
    end
  end

  context "When block starts with a star, it" do
    should "tell square that it's a list, so that it will be wrapped in ul tags" do

      markup = "* Yadda"
      result = "<ul><li>Yadda</li></ul>"

      assert_equal result, Flannel.quilt(markup)
    end
  end
end
