FactoryGirl.define do
  factory :category do
    name 'Category Name'

    transient do
      child_count 0
    end

    after(:create) do |category, evaluator|
      create_list(:category_relationship, evaluator.child_count,
                                          parent: category)
    end

    factory :root_category do
      after(:create) do |category, evaluator|
        create(:category_relationship, parent: nil, child: category)
      end
    end
  end
end
