FactoryGirl.define do
  factory :order_item do
    quantity 10
    price 10.0
    order
    product
  end
end
