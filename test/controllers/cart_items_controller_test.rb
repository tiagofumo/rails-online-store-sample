require 'test_helper'

class CartItemsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @product = products(:arduino_uno)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should add cart item" do
    post :create, product_id: @product, quantity: 1
    assert_response :success
  end

  test "should destroy cart item" do
    delete :destroy, id: @product
    assert_response :success
  end

end
