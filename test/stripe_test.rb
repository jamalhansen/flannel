require 'test_helper'
require 'stripe'

class StripeTest < Test::Unit::TestCase
  context "basic operations" do
    setup do
      @stripe = Flannel::Stripe.stitch "foo"
    end

    should "be of of kind Flannel::Stripe" do
      assert Flannel::Stripe, @stripe.class
    end

    should "create instance with stitch" do
      assert_equal "foo", @stripe.weave
    end

    should "return html fragment with to_h" do
      assert_equal "foo", @stripe.to_h
    end
  end

  context "building wiki links" do
    setup do
      wiki_link = lambda { |keyword| "http://www.example.com/foo/#{keyword}"}
      @stripe = Flannel::Stripe.stitch "the -roof is on fire>", :wiki_link => wiki_link
    end

    should "build wiki links based on a lambda" do
      assert_equal "http://www.example.com/foo/cheese", @stripe.wiki_link("cheese")
    end

    should "find and replace wiki link markup" do
      assert_equal 'the <a href="http://www.example.com/foo/roof-is-on-fire">roof is on fire</a>', @stripe.to_h
    end
    
    should "permalink topics when making wiki links" do
      assert_equal "http://www.example.com/foo/cheese-tastes-good", @stripe.wiki_link("cheese tastes good")
    end
  end

  context "no lambda is provided" do
    setup do
      @stripe = Flannel::Stripe.stitch "baz"
    end

    should "output the wiki text" do
      assert_equal "cheese", @stripe.wiki_link("-cheese>")
    end

    should "prermalink the wiki text" do
      assert_equal "cheese-is-good", @stripe.wiki_link("-cheese is good>")
    end
  end

  context "replacing wiki links" do
    should "replace surrounded by - and > with a wiki link" do
      stripe = Flannel::Stripe.stitch("red, -green>, refactor")
      assert_equal 'red, <a href="green">green</a>, refactor', stripe.to_h
    end

    should "not replace surrounded by - and > with a wiki link if spaced" do
      stripe = Flannel::Stripe.stitch("red, - green >, refactor")
      assert_equal 'red, - green >, refactor', stripe.to_h
    end

    should "not replace surrounded by - and > with a wiki link if spaced on right" do
      stripe = Flannel::Stripe.stitch("red, -green >, refactor")
      assert_equal 'red, -green >, refactor', stripe.to_h
    end

    should "not replace surrounded by - and > with a wiki link if spaced on left" do
      stripe = Flannel::Stripe.stitch("red, - green>, refactor")
      assert_equal 'red, - green>, refactor', stripe.to_h
    end
  end

  context "preformatted text" do
    should "html escape preformatted text" do
      stripe = Flannel::Stripe.stitch "<p>& foo</p>", :style => :preformatted
      assert_equal "&lt;p&gt;&amp; foo&lt;/p&gt;", stripe.to_h
    end
  end

  context "making permalinks" do
    setup do
      @stripe = Flannel::Stripe.stitch ""
    end

    should "replace spaces with dashes" do
      assert_equal "get-the-box", @stripe.permalink("get the box")
    end

    should "replace multiple spaces with single dashes" do
      assert_equal "get-the-box", @stripe.permalink("get    the box")
    end

    should "replace odd characters with dashes" do
      assert_equal "get-the-box", @stripe.permalink("get the @#)(* box")
    end
  end
end
