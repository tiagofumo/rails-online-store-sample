require 'test_helper'

class CategoryRelationshipTest < ActiveSupport::TestCase
  test "CategoryRelationship without child_id should not be valid" do
    assert_not CategoryRelationship.new(child_id: nil).valid?
  end
end
