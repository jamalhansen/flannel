require 'test_helper'

class FlannelTest < Test::Unit::TestCase
  should "wrap functionality up in a neat package" do
    markup = ":header_two foo Foo\n\n:list list Bar"
    assert_equal "<h2 id='foo'>Foo</h2>\n\n<ul id='list'><li>Bar</li></ul>", Flannel.quilt(markup)
  end

  should "return nil if text is nil" do
    assert_nil Flannel.quilt(nil)
  end

  should "parse paragraphs correctly" do
    input = ":paragraph p_one\nThis is paragraph one.\n\n:paragraph p_two\nThis is paragraph two.\n\n:paragraph p_three\nThis is paragraph three. Watchout for the end of file.\n"
    output = "<p id='p_one'>This is paragraph one.</p>\n\n<p id='p_two'>This is paragraph two.</p>\n\n<p id='p_three'>This is paragraph three. Watchout for the end of file.</p>"
    assert_equal output, Flannel.quilt(input)
  end
  
  context "basic behavior" do
    should "strip and convert underscores to pre tags" do
      markup = ":preformatted foo\nfoo\n\n   bar\n"
      assert_equal "<pre id='foo'>foo\n\n   bar\n</pre>",  Flannel.quilt(markup)
    end

    should "escape preformatted text" do
      markup = ":preformatted math\n4 - 2 > 2 - 2\n"
      assert_equal "<pre id='math'>4 - 2 &gt; 2 - 2\n</pre>",  Flannel.quilt(markup)
    end
  end

  context "When block starts with header, it" do
    should "convert one to a header one" do
      markup = ":header_one h\n Some header"
      result = "<h1 id='h'>Some header</h1>"

      assert_equal result,  Flannel.quilt(markup)
    end

    should "convert two equals to a header two" do
      markup = ":header_two h\n Some header"
      result = "<h2 id='h'>Some header</h2>"

      assert_equal result,  Flannel.quilt(markup)
    end
  end

  context "When block is a list, it" do
    should "be wrapped in ul tags" do

      markup = ":list list\n Yadda\nYadda\nYadda"
      result = "<ul id='list'><li>Yadda</li>\n<li>Yadda</li>\n<li>Yadda</li></ul>"

      assert_equal result, Flannel.quilt(markup)
    end
  end
end
