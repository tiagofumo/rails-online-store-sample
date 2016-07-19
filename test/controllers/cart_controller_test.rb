require 'test_helper'

class CartControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get addItem" do
    get :addItem
    assert_response :success
  end

  test "should get destroyItem" do
    get :destroyItem
    assert_response :success
  end

end
