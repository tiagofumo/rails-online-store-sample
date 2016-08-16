require "rails_helper"

RSpec.describe CartItemsController, :type => :controller do
  describe "GET #index" do
    it "renders the index template" do
      sign_in
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("index")
    end

    it "loads all the cart_items to @cart_items" do
      user = sign_in
      cart_items = [
        FactoryGirl.create(:cart_item, user: user),
        FactoryGirl.create(:cart_item, user: user)
      ]
      get :index
      expect(assigns(:cart_items)).to match_array(cart_items)
    end
  end

  describe "POST #create" do
    it "saves new cart item" do
      sign_in
      product = FactoryGirl.create(:product)
      expect do
        post :create, product_id: product.id
      end.to change(CartItem, :count).by(1)
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the cart item" do
      user = sign_in
      cart_item = FactoryGirl.create(:cart_item, user: user)
      expect do
        delete :destroy, id: cart_item.id
      end.to change(CartItem, :count).by(-1)
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
