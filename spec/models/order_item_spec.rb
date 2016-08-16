require "rails_helper"

RSpec.describe OrderItem, :type => :model do
  context 'validations' do
  end

  context 'associations' do
    it{ is_expected.to belong_to(:product) }
    it{ is_expected.to belong_to(:order) }
  end

  context '#weight' do
    it "matches total order item weight" do
      weight = 120
      quantity = 5
      product = FactoryGirl.create(:product, weight: weight)
      order_item = FactoryGirl.build(:order_item,
                                    product: product,
                                    quantity: quantity)
      expect(order_item.weight).to eq(weight * quantity)
    end
  end

  context '#cost' do
    it "matches total order item cost" do
      price = 24.95
      quantity = 3
      order_item = FactoryGirl.build(:order_item,
                                      price: price,
                                      quantity: quantity)
      expect(order_item.cost.to_f).to eq(price * quantity)
    end
  end
end
