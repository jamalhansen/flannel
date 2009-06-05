require 'test_helper'
require 'stripe'

class StripeTest < Test::Unit::TestCase
  should "be of of kind Flannel::Stripe" do
    stripe = Flannel::Stripe.stitch :thread => "foo"
    assert Flannel::Stripe, stripe.class
  end

  should "create instance with stitch" do
    stripe = Flannel::Stripe.stitch :thread => "foo"
    assert_equal "foo", stripe.thread
  end

  context "When building wiki links, Stripe" do
    should "build wiki links" do
      wiki_link = lambda { |keyword| "http://www.example.com/foo/#{keyword}/"}
      stripe = Flannel::Stripe.stitch :wiki_link => wiki_link

      assert_equal "http://www.example.com/foo/bar/", stripe.wiki_link("bar")
    end

    should "build wiki links based on a lambda" do
      wiki_link = lambda { |keyword| "http://www.rubyyot.com/foo/#{keyword}/"}
      stripe = Flannel::Stripe.stitch :wiki_link => wiki_link

      assert_equal "http://www.rubyyot.com/foo/cheese/", stripe.wiki_link("cheese")
    end

    should "should make topics into permalinks" do
      stripe = Flannel::Stripe.stitch
      assert_equal "get-the-box", stripe.permalink("get the box")
    end

    should "permalink topics when making wiki links" do
      wiki_link = lambda { |keyword| "http://www.example.com/foo/#{keyword}/"}
      stripe = Flannel::Stripe.stitch :wiki_link => wiki_link

      assert_equal "http://www.example.com/foo/cheese-tastes-good/", stripe.wiki_link("cheese tastes good")
    end

    should "find and replace wiki link markup" do
      wiki_link = lambda { |keyword| "../foo/#{keyword}"}
      stripe = Flannel::Stripe.stitch :wiki_link => wiki_link, :thread => "the -roof is on fire>"

      assert_equal 'the <a href="../foo/roof-is-on-fire">roof is on fire</a>', stripe.to_h
    end
  end
end
