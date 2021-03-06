require 'test_helper'

class HtmlFormatterTest < Test::Unit::TestCase
  context "basic operations" do
    setup do
      @formatter = Flannel::HtmlFormatter.new
    end
    
    should "return html fragment with format" do
      assert_equal "<p id='bar'>foo</p>", @formatter.do('foo', :paragraph, "bar")
    end
    
    context "subdirectories" do
      should "handle subdirectories and not display directory info" do
        result = @formatter.do("I think it -cheese/tastes good>.", :paragraph)
        assert_equal '<p>I think it <a href="cheese/tastes-good">tastes good</a>.</p>', result
      end
    end
      
    context "blockquotes" do
      should "wrap a blockquoted block in blockquotes" do
        result = @formatter.do("Ruby is #1", :blockquote)
        assert_equal '<blockquote>Ruby is #1</blockquote>', result
      end
    end

    context "links" do
      should "output the link" do
        assert_equal '<p><a href="cheese">cheese</a></p>', @formatter.do("-cheese>", :paragraph)
      end
      
      should "hyphenate words" do
        result = @formatter.do("-cheese is good>", :paragraph)
        assert_equal '<p><a href="cheese-is-good">cheese is good</a></p>', result
      end

      should "replace text surrounded by - and > with a wiki link" do
        result = @formatter.do("red, -green>, refactor", :paragraph)
        assert_equal '<p>red, <a href="green">green</a>, refactor</p>',result
      end

      should "not replace text surrounded by - and > with a wiki link if spaced" do
        result = @formatter.do("red, - green >, refactor", :paragraph)
        assert_equal '<p>red, - green >, refactor</p>', result
      end

      should "not replace text surrounded by - and > with a wiki link if spaced on right" do
        result = @formatter.do("red, -green >, refactor", :paragraph)
        assert_equal '<p>red, -green >, refactor</p>', result
      end

      should "not replace surrounded by - and > with a wiki link if spaced on left" do
        result = @formatter.do("red, - green>, refactor", :paragraph)
        assert_equal '<p>red, - green>, refactor</p>', result
      end
    end

    context "preformatted text" do
      should "html escape preformatted text" do
        result = @formatter.do("<p>& foo</p>", :preformatted)
        assert_equal "<pre>&lt;p&gt;&amp; foo&lt;/p&gt;</pre>", result
      end
    end
    
    context "definition list" do
      should "format definition list" do
        result = @formatter.do("flannel - a wonderful markup dsl\nruby - a wonderful programming language", :dlist)
        assert_equal "<dl><dt>flannel</dt><dd>a wonderful markup dsl</dd>\n<dt>ruby</dt><dd>a wonderful programming language</dd></dl>", result
      end
    end
    
    context "image" do
      should "format image" do
        result = @formatter.do("This is a picture of a cat\n/images/cat.png", :image)
        assert_equal "<img src='/images/cat.png' alt='This is a picture of a cat' title='This is a picture of a cat' />", result
      end
    end

    context "making permalinks" do
      should "replace spaces with dashes" do
        assert_equal "get-the-box", @formatter.permalink("get the box")
      end

      should "replace multiple spaces with single dashes" do
        assert_equal "get-the-box", @formatter.permalink("get    the box")
      end

      should "replace odd characters with dashes" do
        assert_equal "get-the-box", @formatter.permalink("get the @#)(* box")
      end
      
      should "not be greedy in matching" do
        result = @formatter.do "a -foo> and a -bar>.", :paragraph
        assert_equal '<p>a <a href="foo">foo</a> and a <a href="bar">bar</a>.</p>', result
      end
    end
  end
end
