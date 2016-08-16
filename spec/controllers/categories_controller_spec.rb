require "rails_helper"

RSpec.describe CategoriesController, :type => :controller do
  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("index")
    end

    it "loads all the categories to @categories" do
      categories = [
        FactoryGirl.create(:category),
        FactoryGirl.create(:category)
      ]
      get :index
      expect(assigns(:categories)).to match_array(categories)
    end
  end

  describe "GET #show" do
    before(:each) do
      @category = FactoryGirl.create(:category)
    end

    it "renders the products/index template" do
      get :show, id: @category.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("products/index")
    end

    it "loads the correct category to @category in the controller" do
      get :show, id: @category.id
      expect(assigns(:category)).to match(@category)
    end
  end
end
