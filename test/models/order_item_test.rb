require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  test "OrderItem weight should match" do
    assert_equal 300, order_items(:one).weight
    assert_equal 100, order_items(:two).weight
  end

  test "OrderItem cost should match" do
    assert_equal 79.9, order_items(:one).cost.to_f
    assert_equal 29.95, order_items(:two).cost.to_f
  end
end
