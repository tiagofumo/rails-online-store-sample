json.array!(@addresses) do |address|
  json.extract! address, :id, :title, :receiver, :street, :country, :city, :postal_code, :phone, :state, :user_id
  json.url address_url(address, format: :json)
end
