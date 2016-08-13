require "rails_helper"

RSpec.describe Address, :type => :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:receiver) }
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:postal_code) }
    it { is_expected.to validate_presence_of(:user) }
  end

  context 'country_name' do
    it "matches country name" do
      expect(Address.new(country: 'BR').country_name).to eq('Brazil')
      expect(Address.new(country: 'US').country_name).to eq('United States')
      expect(Address.new(country: 'PL').country_name).to eq('Poland')
      expect(Address.new(country: 'DE').country_name).to eq('Germany')
    end
  end
end
