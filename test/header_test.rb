require 'test_helper'

class HeaderTest < Test::Unit::TestCase
  def setup
    @service = Flannel::MarkupToHtml.new
  end

  context "When  block starts with one or more equals signs, Flannel" do
    should "convert one equals to a header one" do
      markup = "= Some header"
      result = "<h1>Some header</h1>"

      assert_equal result, @service.to_h(markup)
    end

    should "convert two equals to a header two" do
      markup = "== Some header"
      result = "<h2>Some header</h2>"

      assert_equal result, @service.to_h(markup)
    end
  end
end
