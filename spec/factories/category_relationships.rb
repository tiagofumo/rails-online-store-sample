FactoryGirl.define do
  factory :category_relationship do
    association :child, factory: :category
  end
end
