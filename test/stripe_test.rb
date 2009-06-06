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

  context "When building wiki links" do
    setup do
      wiki_link = lambda { |keyword| "http://www.example.com/foo/#{keyword}/"}
      @stripe = Flannel::Stripe.stitch "the -roof is on fire>", :wiki_link => wiki_link
    end

    should "build wiki links based on a lambda" do
      assert_equal "http://www.example.com/foo/cheese/", @stripe.wiki_link("cheese")
    end

    should "output the wiki text if no lambda was provided" do
      stripe = Flannel::Stripe.stitch "baz"

      assert_equal "cheese", stripe.wiki_link("cheese")
    end

    should "should make topics into permalinks" do
      assert_equal "get-the-box", @stripe.permalink("get the box")
    end

    should "permalink topics when making wiki links" do
      assert_equal "http://www.example.com/foo/cheese-tastes-good/", @stripe.wiki_link("cheese tastes good")
    end

    should "find and replace wiki link markup" do
      assert_equal 'the <a href="http://www.example.com/foo/roof-is-on-fire/">roof is on fire</a>', @stripe.to_h
    end
  end
end
