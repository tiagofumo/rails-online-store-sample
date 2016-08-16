FactoryGirl.define do
  factory :product_picture do
    trait :sparkfun_pic do
      sparkfun_link 'https://cdn.sparkfun.com//assets/parts/6/3/4/3/11021-01c.jpg'
    end

    product
    default false

    factory :primary_picture do
      default true
    end
  end
end
