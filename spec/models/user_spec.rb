require "rails_helper"

RSpec.describe User, :type => :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  context '#first_name' do
    it "matches first name" do
      user = User.new name: 'George Master'
      expect(user.first_name).to eq('George')
    end
  end

  context '#last_name' do
    it "matches last name" do
      user = User.new name: 'George Master'
      expect(user.last_name).to eq('Master')
    end
  end
end
