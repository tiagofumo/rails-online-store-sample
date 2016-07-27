class ShippingMethod < ActiveRecord::Base
  def cost(cart_items)
    total_weight = cart_items.inject(0) do |sum, cart_item|
      sum + cart_item.weight
    end
    if total_weight > base_cost_max_weight
      base_cost + extra_cost_per_gram * (total_weight - base_cost_max_weight)
    else
      base_cost
    end
  end
end
