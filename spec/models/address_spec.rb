require "rails_helper"

RSpec.describe Address, :type => :model do
  it "matches country name" do
    expect(Address.new(country: 'BR').country_name).to eq('Brazil')
    expect(Address.new(country: 'US').country_name).to eq('United States')
    expect(Address.new(country: 'PL').country_name).to eq('Poland')
    expect(Address.new(country: 'DE').country_name).to eq('Germany')
  end

  it "is valid" do
    address = FactoryGirl.build(:address)
    expect(address).to be_valid
  end

  it "is not valid" do
    address = FactoryGirl.build(:address)
    [ :title, :receiver, :street, :country, :state,
        :city, :postal_code ].each do |field|
      address_clone = address.clone
      address_clone.send("#{field}=", "")
      expect(address_clone).to_not be_valid
    end
    address.user = nil
    expect(address).to_not be_valid
  end
end
