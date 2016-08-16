require "rails_helper"

RSpec.describe ShippingMethod, :type => :model do
  context 'validations' do
  end

  context 'associations' do
  end

  context '#cost' do
    it 'matches total shipping cost for a group of cart items' do
      shipping_method = FactoryGirl.build(:shipping_method,
                                          base_cost: 10.00,
                                          extra_cost_per_gram: 0.05,
                                          base_cost_max_weight: 250)
      local_pickup = FactoryGirl.build(:local_pickup)
      product_80 = FactoryGirl.create(:product, weight: 80)
      product_120 = FactoryGirl.create(:product, weight: 120)
      product_170 = FactoryGirl.create(:product, weight: 170)
      cart_item_80 = FactoryGirl.build(:cart_item, product: product_80,
                                       quantity: 3)
      cart_item_120 = FactoryGirl.build(:cart_item, product: product_120,
                                        quantity: 5)
      cart_item_170 = FactoryGirl.build(:cart_item, product: product_170,
                                        quantity: 4)
      expect(local_pickup.cost([cart_item_120])).to eq(0)
      expect(local_pickup.cost([cart_item_120, cart_item_80])).to eq(0)
      expect(local_pickup.cost([cart_item_170, cart_item_120])).to eq(0)
      expect(local_pickup.cost([cart_item_170, cart_item_80])).to eq(0)
      expect(local_pickup.cost([cart_item_170])).to eq(0)

      expect(shipping_method.cost([cart_item_80])).to eq(10.0)
      expect(shipping_method.cost([cart_item_120])).to eq(27.5)
      expect(shipping_method.cost([cart_item_120, cart_item_80])).to eq(39.5)
      expect(shipping_method.cost([cart_item_170, cart_item_120])).to eq(61.5)
      expect(shipping_method.cost([cart_item_170, cart_item_80])).to eq(43.5)
      expect(shipping_method.cost([cart_item_170])).to eq(31.5)
    end
  end
end
