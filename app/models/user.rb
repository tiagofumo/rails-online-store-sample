class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" },
                             default_url: "johndoe_gray.png"
                             # processors: [ :papercrop ]
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :name,  presence: true, length: { maximum: 50 }
  # crop_attached_file :avatar
  enum privacy_setting: [:public_profile, :restricted_profile, :private_profile]
  has_many :addresses

  def first_name
    name.split.first
  end

  def last_name
    name.split.last
  end
end
