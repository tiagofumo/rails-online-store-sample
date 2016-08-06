require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = categories(:arduino)
  end

  test "Category should be valid" do
    assert @category.valid?
  end

  test "Category without a name should not be valid" do
    @category.name = ''
    assert_not @category.valid?
  end

  test "Category's children should not be empty" do
    assert_not @category.children.empty?
  end
end
