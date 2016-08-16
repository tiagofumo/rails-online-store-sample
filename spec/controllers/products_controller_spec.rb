require "rails_helper"

RSpec.describe ProductsController, :type => :controller do
  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("index")
    end

    it "loads all of the posts into @posts" do
      products = [
        FactoryGirl.create(:product),
        FactoryGirl.create(:product)
      ]
      get :index
      expect(assigns(:products)).to match_array(products)
    end
  end

  describe "GET #show" do
    it "renders show template" do
      product = FactoryGirl.create(:product)
      get :show, id: product.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("show")
    end

    it "loads all of the posts into @posts" do
      product = FactoryGirl.create(:product)
      get :show, id: product.id
      expect(assigns(:product)).to match(product)
    end
  end
end
