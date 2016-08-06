class Product < ActiveRecord::Base
  has_many :order_items
  has_many :product_pictures
  has_and_belongs_to_many :categories
  has_one  :primary_picture, -> { where(default: true) },
           class_name: 'ProductPicture'
  validates :name,  presence: true, length: { maximum: 80 }
  validates :price, presence: true, numericality: { greater_than: 0.0 }
  validates :description,  presence: true
  validates :stock, presence: true, numericality: { greater_than: 0 }
end
