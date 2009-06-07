require 'test_helper'

class QuilterTest < Test::Unit::TestCase
  context "basic behavior" do
    setup do
      @quilter = Flannel::Quilter.new
    end

    should "strip and convert underscores to pre tags" do
      markup = "_foo\n\n   bar\n_"
      assert_equal "<pre>foo\n\n   bar</pre>", @quilter.cut(markup)
    end

    should "preformat text when both start and end line have the markers" do
      markup = "_foo\n\n_   bar"
      assert_equal "<pre>foo\n\n   bar</pre>", @quilter.cut(markup)
    end

    should "not replace in preformatted text" do
      markup = "_4 - 2 > 2 - 2\n_"
      assert_equal '<pre>4 - 2 &gt; 2 - 2</pre>', @quilter.cut(markup)
    end
  end

  context "When block starts with one or more equals signs, it" do
    setup do
      @quilter = Flannel::Quilter.new
    end

    should "convert one equals to a header one" do
      markup = "= Some header"
      result = "<h1>Some header</h1>"

      assert_equal result, @quilter.cut(markup)
    end

    should "convert two equals to a header two" do
      markup = "== Some header"
      result = "<h2>Some header</h2>"

      assert_equal result, @quilter.cut(markup)
    end
  end

  context "When block starts with a star, it" do
    should "tell square that it's a list, so that it will be wrapped in ul tags" do
      quilter = Flannel::Quilter.new
      markup = "* Yadda"
      result = "<ul><li>Yadda</li></ul>"

      assert_equal result, quilter.cut(markup)
    end
  end
end
