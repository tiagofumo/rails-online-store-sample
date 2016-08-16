require "rails_helper"

RSpec.describe CartItem, :type => :model do
  context 'validations' do
  end

  context 'associations' do
    it{ is_expected.to belong_to(:product) }
    it{ is_expected.to belong_to(:user) }
  end

  context '#weight' do
    it "matches total cart item weight" do
      weight = 120
      quantity = 5
      product = FactoryGirl.create(:product, weight: weight)
      cart_item = FactoryGirl.build(:cart_item,
                                    product: product,
                                    quantity: quantity)
      expect(cart_item.weight).to eq(weight * quantity)
    end
  end

  context '#cost' do
    it "matches total cart item cost" do
      price = 24.95
      quantity = 3
      product = FactoryGirl.create(:product, price: price)
      cart_item = FactoryGirl.build(:cart_item,
                                    product: product,
                                    quantity: quantity)
      expect(cart_item.cost.to_f).to eq(price * quantity)
    end
  end
end
