require "rails_helper"

RSpec.describe Product, :type => :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(80) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0.0) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:stock) }
    it { is_expected.to validate_numericality_of(:stock).is_greater_than(0) }
  end

  context 'associations' do
    it {is_expected.to have_one(:primary_picture) }
    it {is_expected.to have_many(:product_pictures) }
    it {is_expected.to have_and_belong_to_many(:categories) }
    it {is_expected.to have_many(:order_items) }
  end
end
