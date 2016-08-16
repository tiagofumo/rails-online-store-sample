require "rails_helper"

RSpec.describe Order, :type => :model do
  context 'validations' do
  end

  context 'associations' do
    it{ is_expected.to have_many(:order_items) }
    it{ is_expected.to belong_to(:user) }
    it{ is_expected.to belong_to(:address) }
    it{ is_expected.to belong_to(:shipping_method) }
  end

  context '#items' do
    it "matches the ammount of distinct order items" do
      order = FactoryGirl.create(:order, order_item_count: 3)
      expect(order.items).to eq(3)
    end
  end

  context '#units' do
    it "matches the total ammount of units in an order" do
      order = FactoryGirl.create(:order, order_item_count: 0)
      FactoryGirl.create(:order_item, order: order, quantity: 5)
      FactoryGirl.create(:order_item, order: order, quantity: 2)
      FactoryGirl.create(:order_item, order: order, quantity: 1)
      expect(order.units).to eq(8)
    end
  end

  context '#status_name' do
    it "matches the total ammount of units in an order" do
      [
        { key: :new_order, value: 'New Order'},
        { key: :picking, value: 'Picking'},
        { key: :packing, value: 'Packing'},
        { key: :shipped, value: 'Shipped'},
        { key: :ready_for_pickup, value: 'Ready for Pickup'},
      ].each do |hash|
        expect(Order.new(status: hash[:key]).status_name).to eq(hash[:value])
      end
    end
  end

  context '#subtotal' do
    it 'matches the sum of order items costs' do
      order_item_count = 3
      single_item_cost = FactoryGirl.build(:order_item).cost
      order = FactoryGirl.create(:order, order_item_count: order_item_count)
      expect(order.subtotal).to eq(single_item_cost * order_item_count)
    end
  end

  context '#shipping_cost' do
    it 'matches the shipping cost for the order' do
      base_cost = 10.00
      extra_cost_per_gram = 0.05
      base_cost_max_weight = 250
      order_item_count = 3
      shipping_method = FactoryGirl.create(
        :shipping_method,
        base_cost: base_cost,
        extra_cost_per_gram: extra_cost_per_gram,
        base_cost_max_weight: base_cost_max_weight)
      order = FactoryGirl.create(:order, order_item_count: order_item_count,
                                 shipping_method: shipping_method)
      single_item_weight = FactoryGirl.build(:order_item).weight
      extra_weight = single_item_weight* order_item_count - base_cost_max_weight
      expected_shipping_cost = base_cost +
        (extra_weight > 0 ? extra_weight * extra_cost_per_gram : 0)

      expect(order.shipping_cost).to eq(expected_shipping_cost)
    end
  end

  context '#total_cost' do
    it 'matches them sum of subtotal and shipping cost' do
      order = FactoryGirl.create(:order, order_item_count: 3)
      expected_total_cost = order.subtotal + order.shipping_cost
      expect(order.total_cost).to eq(expected_total_cost)
    end
  end
end
