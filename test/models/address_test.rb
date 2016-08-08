require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test "Should match country name" do
    assert_equal 'Brazil', Address.new(country: 'BR').country_name
    assert_equal 'United States', Address.new(country: 'US').country_name
    assert_equal 'Poland', Address.new(country: 'PL').country_name
    assert_equal 'Germany', Address.new(country: 'DE').country_name
  end
end
