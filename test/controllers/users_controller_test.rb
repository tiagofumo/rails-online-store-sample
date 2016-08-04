require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @user = users(:george)
    @unsaved_user = { name: 'example',
                      email: 'example@example.com',
                      password: '159753' }
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: @unsaved_user
  end

    assert_redirected_to root_url
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should destroy user" do
    sign_in @user
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to root_url
  end
end
