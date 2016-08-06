require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  setup do
    @product = products(:arduino_uno)
  end

  test 'Product without name should not be valid' do
    @product.name = ''
    assert_not @product.valid?
  end

  test 'Product without description should not be valid' do
    @product.description = ''
    assert_not @product.valid?
  end

  test 'Product without stock should not be valid' do
    @product.stock = 0
    assert_not @product.valid?
  end

  test 'Product without price should not be valid' do
    @product.price = 0.0
    assert_not @product.valid?
  end
end
