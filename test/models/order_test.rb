require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  setup do
    @george_usps_firstclass = orders(:george_usps_firstclass)
    @george_local_pickup = orders(:george_local_pickup)
  end

  test "Should match ammount of different products in order" do
    assert_equal 1, @george_usps_firstclass.items
    assert_equal 1, @george_local_pickup.items
  end

  test "Should match ammount of units in order" do
    assert_equal 1, @george_usps_firstclass.units
    assert_equal 2, @george_local_pickup.units
  end

  test "Should match status name in order" do
    @order = orders(:george_local_pickup)
    [
      [ :new_order, "New Order" ],
      [ :picking, "Picking" ],
      [ :packing, "Packing" ],
      [ :shipped, "Shipped" ],
      [ :ready_for_pickup, "Ready for Pickup" ],
    ].each do |i|
      @order.status = i[0]
      assert_equal i[1], @order.status_name, "Order status: :#{@order.status}"
    end
  end

  test "Should match order subtotal" do
    assert_equal 29.95, @george_usps_firstclass.subtotal.to_f
    assert_equal 79.9, @george_local_pickup.subtotal.to_f
  end

  test "Should match order shipping cost" do
    assert_equal 9.99, @george_usps_firstclass.shipping_cost.to_f
    assert_equal 0.0, @george_local_pickup.shipping_cost.to_f
  end

  test "Should match total cost" do
    assert_equal 39.94, @george_usps_firstclass.total_cost.to_f
    assert_equal 79.9, @george_local_pickup.total_cost.to_f
  end
end
