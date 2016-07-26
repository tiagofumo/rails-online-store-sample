require 'json'
require 'open-uri'
require 'pp'

# Destroy all products first
# ProductImage.where.not(sparkfun_link: nil).delete_all
# Product.where.not(sparkfun_id: nil).destroy_all

products = JSON.parse open('./products.json').read

categories = Category.where.not(sparkfun_id: nil).to_a.index_by(&:sparkfun_id)

counter = 0
products.each do |product|
  if counter > products.length / 100
    print '='
    counter = 0
  end
  counter += 1

  p = Product.create sparkfun_id: product['id'],
                     sku: product['sku'],
                     name: product['name'],
                     description: product['description'],
                     created_at: product['date_published'],
                     updated_at: product['date_published'],
                     price: product['price'],
                     stock: product['quantity'],
                     backorder_allowed: product['backorder_allowed'],
                     rohs: product['is_rohs_compliant'],
                     open_source: product['is_oshw'],
                     pack_length: product['pack_length'].gsub(/\D/, ''),
                     pack_width: product['pack_width'].gsub(/\D/, ''),
                     pack_height: product['pack_height'].gsub(/\D/, ''),
                     weight: product['packed_weight'].gsub(/[a-zA-Z]/, '').to_f * 450

  product['categories'].each do |category_hash|
    key = category_hash.keys.first.to_i
    if categories.key? key
      p.categories.push categories[key]
    end
  end

  default_picture = true
  product['images'].each do |image_hash|
    ProductPicture.create product_id: p.id,
                          default: default_picture,
                          sparkfun_link: image_hash['600']
    default_picture = false
  end
end
