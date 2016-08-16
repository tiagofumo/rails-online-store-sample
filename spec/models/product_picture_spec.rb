require "rails_helper"

RSpec.describe ProductPicture, :type => :model do
  context 'validations' do
  end

  context 'associations' do
    it { is_expected.to belong_to(:product) }
  end

  context '#url' do
    it 'matches the url from sparkfun' do
      url = 'https://cdn.sparkfun.com//assets/parts/1/1/6/6/8/13959-01.jpg'
      picture = ProductPicture.new sparkfun_link: url
      {
        large: url,
        medium: 'https://cdn.sparkfun.com/r/188-188//assets/parts/1/1/6/6/8/13959-01.jpg',
        small: 'https://cdn.sparkfun.com/r/92-92//assets/parts/1/1/6/6/8/13959-01.jpg',
        thumb: 'https://cdn.sparkfun.com/r/58-58//assets/parts/1/1/6/6/8/13959-01.jpg'
      }.each do |key, link|
        expect(picture.url(key)).to eq(link)
      end
    end
  end
end
