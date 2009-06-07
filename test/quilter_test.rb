require 'test_helper'

class QuilterTest < Test::Unit::TestCase
  should "strip and convert underscores to pre tags" do
    markup = "_foo\n\n   bar\n_"
    quilter = Flannel::Quilter.new
    assert_equal "<pre>foo\n\n   bar</pre>", quilter.cut(markup)
  end

  should "preformat text when both start and end line have the markers" do
    markup = "_foo\n\n_   bar"
    quilter = Flannel::Quilter.new
    assert_equal "<pre>foo\n\n   bar</pre>", quilter.cut(markup)
  end

  #TODO escape preformatted

  context "When building wiki links, Square" do
    should "not replace in preformatted text" do
      quilter = Flannel::Quilter.new
      result = quilter.cut("_4 - 2 > 2 - 2\n_")
      assert_equal '<pre>4 - 2 > 2 - 2</pre>', result
    end
  end

  context "When block starts with one or more equals signs, it" do
    should "convert one equals to a header one" do
      quilter = Flannel::Quilter.new
      markup = "= Some header"
      result = "<h1>Some header</h1>"

      assert_equal result, quilter.cut(markup)
    end

    should "convert two equals to a header two" do
      quilter = Flannel::Quilter.new
      markup = "== Some header"
      result = "<h2>Some header</h2>"

      assert_equal result, quilter.cut(markup)
    end
  end

  context "When square is list" do
    should "tell square that it's a list, so that it will be wrapped in ul tags" do
      quilter = Flannel::Quilter.new
      markup = "* Yadda"
      result = "<ul><li>Yadda</li></ul>"

      assert_equal result, quilter.cut(markup)
    end
  end
end
