FactoryGirl.define do
  factory :user do
    name 'George Testman'
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    confirmed_at Date.today

    trait :has_avatar do
      avatar { File.new("#{Rails.root}/spec/support/fixtures/profile_pic.jpg") }
    end

    trait :has_profile_fields do
      add_attribute(:alias) { 'coolalias99' }
      country 'BR'
      profile 'My cool profile'
    end

    trait :has_account_fields do
      company 'My Company'
      phone '+55 11 99999 9999'
      fax '+1 555 555 5555'
    end

    factory :user_with_avatar, traits: [:has_avatar]
    factory :complete_user, traits: [ :has_avatar, :has_profile_fields,
                                      :has_account_fields ]
  end
end
