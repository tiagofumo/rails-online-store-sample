class Address < ActiveRecord::Base
  belongs_to :user
  validates :user,  presence: true
  validates :title, :receiver, :street, :country, :state,
            :city, :postal_code, presence: true

  def country_name
    country_iso = ISO3166::Country[country]
    country_iso.translations[I18n.locale.to_s] || country_iso.name
  end
end
