require "rails_helper"

RSpec.describe CategoryRelationship, :type => :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:child_id) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:parent) }
    it { is_expected.to belong_to(:child) }
  end
end
