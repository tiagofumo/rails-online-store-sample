require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    sign_in users(:george)
    @order = orders(:george_local_pickup)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { address_id: @order.address_id,
                             shipping_method_id: @order.shipping_method_id,
                             status: @order.status,
                             tracking_number: @order.tracking_number,
                             user_id: @order.user_id }
    end

    assert_redirected_to orders_path
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end
end
