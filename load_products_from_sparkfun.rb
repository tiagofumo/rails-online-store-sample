require 'json'
require 'open-uri'
require 'pp'
require 'xmlsimple'

# Destroy all categories first
# ProductImage.where.not(sparkfun_link: nil).destroy_all
# Product.all.destroy_all

products = XmlSimple.xml_in('/home/tiagofumo/Downloads/products.xml')['product']

categories = Category.where.not(sparkfun_id: nil)
categories_hash = {}

categories.each do |category|
  categories_hash[category.name] = category.id
end

counter = 0
products.each do |product|
  if counter > products.length / 100
    print '='
    counter = 0
  end
  counter += 1

  category_id = categories_hash[product['category'][0]['content']]

  p = Product.create name: product['name'][0],
                     sparkfun_id: product['id'].to_i,
                     sku: product['sku'][0],
                     price: product['price'][0].to_i,
                     stock: product['quantity'][0].to_i,
                     backorder_allowed: product['backorderAllowed'][0] == 'true',
                     rohs: product['RoHS'][0] == 'true',
                     open_source: product['openSource'] == 'true',
                     country: product['country'][0],
                     pack_length: product['packLength'][0].to_i,
                     pack_width: product['packWidth'][0].to_i,
                     pack_height: product['packHeight'][0].to_i,
                     weight: product['weight'][0].to_i,
                     description: product['description'][0],
                     category_id: category_id
  default = false
  default_found = false
  product['image'].each do |image|
    if image.key? 'default'
      default = image['id']
      default_found = true
    elsif !default_found &&(!default || image['large'][0].slice(-6, 2) == '01')
      default = image['id']
    end
  end

  product['image'].each do |image|
    ProductPicture.create product_id: p.id,
                          default: image['id'] == default,
                          sparkfun_link: image['large'][0]
  end
end
