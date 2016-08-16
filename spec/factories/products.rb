FactoryGirl.define do
  factory :product do
    name 'Arduino Uno R3'
    description 'Arduino is a development platform for electornic projects'
    price 24.95
    stock 10
    weight 120

    transient do
      pictures_count 1
    end

    after(:create) do |product, evaluator|
      create(:primary_picture, :sparkfun_pic, product: product)
      create_list(:product, evaluator.pictures_count - 1, product: product)
    end
  end
end
