FactoryGirl.define do
  factory :address do
    title 'New address'
    receiver 'George Testman'
    street 'Rua Desembargador José Sotero 210'
    country 'BR'
    city 'Aracaju'
    postal_code '49020110'
    state 'Sergipe'
    user
  end
end
