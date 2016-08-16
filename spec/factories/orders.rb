FactoryGirl.define do
  factory :order do
    user
    address
    shipping_method
    status :new_order

    transient do
      order_item_count 1
    end

    after(:create) do |order, evaluator|
      create_list(:order_item, evaluator.order_item_count, order: order)
    end
  end
end
