class ProductPicture < ActiveRecord::Base
  belongs_to :product
  has_attached_file :picture, default_url: "johndoe_gray.png",
                    styles: { large: "600x600>", medium: "188x188>",
                              small: '92x92>',   thumb:  '58x58>' }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  def url(type)
    if sparkfun_link?
      s = sparkfun_link
      h = { medium: 188, small: 92, thumb: 58 }
      if h.key? type
        s.insert 'https://cdn.sparkfun.com/'.length, "r/#{h[type]}-#{h[type]}/"
      end
      s
    else
      picture.url(type)
    end
  end
end
