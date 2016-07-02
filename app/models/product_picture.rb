class ProductPicture < ActiveRecord::Base
  belongs_to :product
  has_attached_file :picture, default_url: "johndoe_gray.png",
                    styles: { large: "600x600>", medium: "200x200>",
                              small: '92x92>',   thumb:  '58x58>' }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
end
