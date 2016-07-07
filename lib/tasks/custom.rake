namespace :custom do
  desc "Load categories, products and images to database"
  task load_database: :environment do
    ProductPicture.delete_all
    Product.delete_all
    Category.delete_all
    load 'load_categories_from_sparkfun.rb'
    load 'load_products_from_sparkfun.rb'
  end
end
