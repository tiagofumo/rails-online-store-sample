require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:george)
  end

  test "User's firstname should not be empty" do
    assert_not @user.first_name.strip.empty?
  end

  test "User's lastname should not be empty" do
    assert_not @user.last_name.strip.empty?
  end

  test "User should be valid" do
    assert @user.valid?
  end

  test "User without name should not be valid" do
    @user = User.new name: '',
                     email: 'testing@example.com',
                     password: '123456',
                     password_confirmation: '123456'
    assert_not @user.valid?
  end

  test "User without email should not be valid" do
    @user = User.new name: 'Testing Goldman',
                     email: '',
                     password: '123456',
                     password_confirmation: '123456'
    assert_not @user.valid?
  end

  test "User without password should not be valid" do
    @user = User.new name: 'Testing Goldman',
                     email: 'testing@example.com',
                     password: '',
                     password_confirmation: ''
    assert_not @user.valid?
  end

  test "Users mismatching password and confirmation should not be valid" do
    @user = User.new name: 'Testing Goldman',
                     email: 'testing@example.com',
                     password: '123456',
                     password_confirmation: '12345'
    assert_not @user.valid?
  end

  test "User model should have devise" do
    assert User.respond_to?('devise_modules') && !User.devise_modules.empty?
  end
end
