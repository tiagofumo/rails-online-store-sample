require 'test_helper'

class ShippingMethodTest < ActiveSupport::TestCase
  setup do
    @usps_firstclass = shipping_methods(:usps_firstclass)
    @local_pickup = shipping_methods(:local_pickup)
  end
  test "Should match total shipping cost" do
    @allan_cart_items = CartItem.where user_id: users(:allan).id
    assert_equal 0.0, @local_pickup.cost([cart_items(:george_one)]).to_f
    assert_equal 0.0, @local_pickup.cost([cart_items(:allan_one)]).to_f
    assert_equal 0.0, @local_pickup.cost([cart_items(:allan_two)]).to_f
    assert_equal 0.0, @local_pickup.cost(@allan_cart_items).to_f
    assert_equal 9.99, @usps_firstclass.cost([cart_items(:george_one)]).to_f
    assert_equal 9.99, @usps_firstclass.cost([cart_items(:allan_one)]).to_f
    assert_equal 17.49, @usps_firstclass.cost([cart_items(:allan_two)]).to_f
    assert_equal 22.49, @usps_firstclass.cost(@allan_cart_items).to_f
  end
end
