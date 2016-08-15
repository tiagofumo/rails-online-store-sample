FactoryGirl.define do
  factory :user do
    name 'George Testman'
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
  end
end
