require 'test_helper'
require 'mocha'

class FeedParserTest < Test::Unit::TestCase
  context "wiring" do
    setup do
      @rubyyot = IO.read(File.join(File.dirname(__FILE__), "..", "features", "fixtures", "rubyyot.rss"))
      @expected_rubyyot = "<ul><li>\n    <a href='http://blog.rubyyot"
    end
    
    should "be set up for feeds" do
      feed = "http://blog.rubyyot.com/tag/rubyyot/feed/rss"
      body = Flannel.quilt "& #{feed}"

      assert_equal(@expected_rubyyot, body[0..40])
    end
  end
  
  context "bootstrapping test" do
    setup do
      @devlicious = IO.read(File.join(File.dirname(__FILE__), "..", "features", "fixtures", "devlicious.rss"))
      @rubyyot = File.read(File.join(File.dirname(__FILE__), "..", "features", "fixtures", "rubyyot.rss"))
    end
    
    should "read rss files" do
      assert_not_nil @devlicious
      assert_not_nil @rubyyot
    end
  end

  context "formatting items" do
    should "format items as link wrapped in li tags" do
      reader = Flannel::FeedParser.new()
      assert_equal("  <li>\n    <a href='foo'>bar</a>\n  </li>\n", reader.format_item('foo', 'bar'))
    end
  end
  
  context "basic call" do
    setup do
      @devlicious = File.read(File.join(File.dirname(__FILE__), "..", "features", "fixtures", "devlicious.rss"))
      @rubyyot = File.read(File.join(File.dirname(__FILE__), "..", "features", "fixtures", "rubyyot.rss"))
      @expected_rubyyot = "  <li>\n    <a href='http://blog.rubyyot.com/2009/05/summer-of-learning-challenge/'>Plans for Rubyyot.com and the Summer of Learning Challenge</a>\n  </li>\n  <li>\n    <a href='http://blog.rubyyot.com/2009/05/using-rack-to-generate-content-from-an-rss-feed/'>Using Rack to generate content from an rss feed</a>\n  </li>\n  <li>\n    <a href='http://blog.rubyyot.com/2009/03/rubyyotcom-is-dead-long-live-rubyyotcom/'>Rubyyot.com is dead; Long live Rubyyot.com</a>\n  </li>\n"
      @expected_devlicious = "  <li>\n    <a href='http://devlicio.us/blogs/sergio_pereira/archive/2009/09/19/javascript-and-its-love-for-zeroes.aspx'>JavaScript and its love for zeroes</a>\n  </li>\n  <li>\n    <a href='http://devlicio.us/blogs/sergio_pereira/archive/2009/06/12/javascript-not-your-father-s-inheritance-model-part-2.aspx'>JavaScript: Not your father's inheritance model - Part 2</a>\n  </li>\n  <li>\n    <a href='http://devlicio.us/blogs/sergio_pereira/archive/2009/06/12/javascript-not-your-father-s-inheritance-model-part-1.aspx'>JavaScript: Not your father's inheritance model - Part 1</a>\n  </li>\n  <li>\n    <a href='http://devlicio.us/blogs/sergio_pereira/archive/2009/03/31/javascript-avoid-the-evil-eval.aspx'>JavaScript: Avoid the Evil eval</a>\n  </li>\n  <li>\n    <a href='http://devlicio.us/blogs/sergio_pereira/archive/2009/02/24/javascript-inner-functions-and-private-members.aspx'>JavaScript, inner functions and private members</a>\n  </li>\n  <li>\n    <a href='http://devlicio.us/blogs/sergio_pereira/archive/2009/02/23/javascript-time-to-grok-closures.aspx'>JavaScript, time to grok closures</a>\n  </li>\n  <li>\n    <a href='http://devlicio.us/blogs/sergio_pereira/archive/2009/02/09/javascript-5-ways-to-call-a-function.aspx'>JavaScript, 5 ways to call a function</a>\n  </li>\n"    
    end
    
    should "substitute feed line with feed" do
      feed = "http://blog.rubyyot.com/tag/rubyyot/feed/rss"
      reader = Flannel::FeedParser.new()
      reader.expects(:get_document).with(feed).returns(@rubyyot)
      body = reader.sub_feeds(feed)
      
      assert_equal(@expected_rubyyot, body)
    end
    
    should "substitute without http://" do
      feed = "blog.rubyyot.com/tag/rubyyot/feed/rss"
      reader = Flannel::FeedParser.new()
      reader.expects(:get_document).with("http://#{feed}").returns(@rubyyot)
      body = reader.sub_feeds(feed)
      
      assert_equal(@expected_rubyyot, body)
    end
    
    should "modify using provided url" do
      feed = "http://devlicio.us/blogs/sergio_pereira/rss.aspx?Tags=JavaScript-Demystified&AndTags=1"
      reader = Flannel::FeedParser.new()
      reader.expects(:get_document).with(feed).returns(@devlicious)
      body = reader.sub_feeds(feed)

      assert_equal(@expected_devlicious, body)
    end
    
    should "format url from body" do
      reader = Flannel::FeedParser.new
      url = reader.format_url("http://blog.rubyyot.com/tag/rubyyot/feed/rss" )
      
      assert_equal("http://blog.rubyyot.com/tag/rubyyot/feed/rss", url)
    end
    
    should "format url from body and add http if necessary" do
      reader = Flannel::FeedParser.new
      url = reader.format_url("blog.rubyyot.com/tag/rubyyot/feed/rss" )
      
      assert_equal("http://blog.rubyyot.com/tag/rubyyot/feed/rss", url)
    end
  end
end

