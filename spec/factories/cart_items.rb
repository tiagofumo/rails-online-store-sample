FactoryGirl.define do
  factory :cart_item do
    quantity 10
    product
    user
  end
end
