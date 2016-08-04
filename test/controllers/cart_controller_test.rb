require 'test_helper'

class CartControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @product = products(:arduino_uno)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should add cart item" do
    post :add_item, product_id: @product, quantity: 1
    assert_response :success
  end

  test "should destroy cart item" do
    delete :destroy_item, id: @product
    assert_response :success
  end

end
