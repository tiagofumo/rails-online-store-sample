require 'test_helper.rb'

class AddressesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    sign_in users(:george)
    @address = addresses(:georges_home)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create address" do
    assert_difference('Address.count') do
      post :create, address: { city: @address.city, country: @address.country, phone: @address.phone, postal_code: @address.postal_code, receiver: @address.receiver, state: @address.state, street: @address.street, title: @address.title, user_id: @address.user_id }
    end

    assert_redirected_to addresses_path
  end

  test "should show address" do
    get :show, id: @address
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @address
    assert_response :success
  end

  test "should update address" do
    patch :update, id: @address, address: { city: @address.city, country: @address.country, phone: @address.phone, postal_code: @address.postal_code, receiver: @address.receiver, state: @address.state, street: @address.street, title: @address.title, user_id: @address.user_id }
    assert_redirected_to addresses_path
  end

  test "should destroy address" do
    assert_difference('Address.count', -1) do
      delete :destroy, id: @address
    end

    assert_redirected_to addresses_path
  end
end
