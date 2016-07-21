class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" },
                             default_url: "johndoe_gray.png"
                             # processors: [ :papercrop ]
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  # crop_attached_file :avatar
  enum privacy_setting: [:public_profile, :restricted_profile, :private_profile]
  attr_accessor :old_password

  def first_name
    name.split.first
  end

  def last_name
    name.split.last
  end
end
