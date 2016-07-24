ShippingMethod.create name: 'Local Pickup', base_cost: 0,
                      extra_cost_per_gram: 0, base_cost_max_weight: 0,
                      delivery_time_min: 0, delivery_time_max: 0

ShippingMethod.create name: 'USPS First-Class', base_cost: 10,
                      extra_cost_per_gram: 0.10, base_cost_max_weight: 250,
                      delivery_time_min: 5, delivery_time_max: 8

ShippingMethod.create name: 'USPS Priority', base_cost: 15,
                      extra_cost_per_gram: 0.15, base_cost_max_weight: 250,
                      delivery_time_min: 3, delivery_time_max: 5

ShippingMethod.create name: 'UPS Ground', base_cost: 12,
                      extra_cost_per_gram: 0.15, base_cost_max_weight: 200,
                      delivery_time_min: 5, delivery_time_max: 8

ShippingMethod.create name: 'UPS 3 Day Select', base_cost: 20,
                      extra_cost_per_gram: 0.2, base_cost_max_weight: 200,
                      delivery_time_min: 3, delivery_time_max: 3

ShippingMethod.create name: 'Fedex', base_cost: 45, extra_cost_per_gram: 0.5,
                      base_cost_max_weight: 250, delivery_time_min: 2,
                      delivery_time_max: 4
