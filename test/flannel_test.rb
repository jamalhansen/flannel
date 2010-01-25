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
end
