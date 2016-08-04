require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @product = products(:arduino_uno)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end
end
