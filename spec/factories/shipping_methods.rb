FactoryGirl.define do
  factory :shipping_method do
    name 'New Shipping Method'
    base_cost 10.00
    extra_cost_per_gram 0.05
    base_cost_max_weight 250
    delivery_time_min 5
    delivery_time_max 8

    factory :local_pickup do
      name 'Local Pickup'
      base_cost 0.0
      extra_cost_per_gram 0.0
      base_cost_max_weight 0
      delivery_time_min 0
      delivery_time_max 0
    end
  end
end
