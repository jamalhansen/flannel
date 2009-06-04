require 'test_helper'
require 'stripe'

class StripeTest < Test::Unit::TestCase
  should "be of of kind Flannel::Stripe" do
    stripe = Flannel::Stripe.new
    assert Flannel::Stripe, stripe.class
  end
end
