json.array!(@orders) do |order|
  json.extract! order, :id, :status, :tracking_number, :user_id, :address_id, :shipping_method_id
  json.url order_url(order, format: :json)
end
