require 'test_helper'

class ProductPictureTest < ActiveSupport::TestCase
  setup do
    @arduino_uno_primary = product_pictures(:arduino_uno_primary_pic)
    @arduino_uno_pic2 = product_pictures(:arduino_uno_pic2)
  end

  test "Should match url" do
    {
      large: 'https://cdn.sparkfun.com//assets/parts/6/3/4/3/11021-01c.jpg',
      medium: 'https://cdn.sparkfun.com/r/188-188//assets/parts/6/3/4/3/11021-01c.jpg',
      small: 'https://cdn.sparkfun.com/r/92-92//assets/parts/6/3/4/3/11021-01c.jpg',
      thumb: 'https://cdn.sparkfun.com/r/58-58//assets/parts/6/3/4/3/11021-01c.jpg',
    }.each do |key, val|
      assert_equal val, @arduino_uno_primary.url(key)
    end
  end
end
