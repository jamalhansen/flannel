require 'test_helper'
require 'flannel/stripe'

class HtmlFormatterTest < Test::Unit::TestCase
  context "basic operations" do
    setup do
      @formatter = Flannel::HtmlFormatter.new
    end
    
    should "return html fragment with format" do
      assert_equal "<p>foo</p>", @formatter.do('foo', :paragraph)
    end
    
    context "subdirectories" do
      should "handle subdirectories and not display directory info" do
	result = @formatter.do("I think it -cheese/tastes good>.", :paragraph)
	assert_equal '<p>I think it <a href="cheese/tastes-good">tastes good</a>.</p>', result
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
