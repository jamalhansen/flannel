require 'test_helper'

class FlannelTest < Test::Unit::TestCase
  should "wrap functionality up in a neat package" do
    markup = "== Foo\n\n* Bar"
    assert_equal "<h2>Foo</h2>\n\n<ul><li>Bar</li></ul>", Flannel.quilt(markup)
  end
end
