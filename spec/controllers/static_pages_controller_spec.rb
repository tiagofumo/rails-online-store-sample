require "rails_helper"

RSpec.describe StaticPagesController, :type => :controller do
  describe "GET #home" do
    it "renders the home template" do
      get :home
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("home")
    end

    it "loads all the products into @products for new products carousel" do
      products = [
        FactoryGirl.create(:product),
        FactoryGirl.create(:product)
      ]
      get :home
      expect(assigns(:products)).to match_array(products)
    end
  end

  describe "GET #about" do
    it "renders the about template" do
      get :about
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("about")
    end
  end
end
