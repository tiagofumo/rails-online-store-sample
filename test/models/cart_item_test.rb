require 'test_helper'

class CartItemTest < ActiveSupport::TestCase
  test "CartItem weight should match" do
    assert_equal 200, cart_items(:george_one).weight
  end

  test "CartItem cost should match" do
    assert_equal 49.9, cart_items(:george_one).cost
  end
end
