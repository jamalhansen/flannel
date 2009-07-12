require 'test_helper'

class FlannelTest < Test::Unit::TestCase
  should "wrap functionality up in a neat package" do
    markup = "== Foo\n\n* Bar"
    assert_equal "<h2>Foo</h2>\n\n<ul><li>Bar</li></ul>", Flannel.quilt(markup)
  end

  should "return nil if text is nil" do
    assert_nil Flannel.quilt(nil)
  end
end
