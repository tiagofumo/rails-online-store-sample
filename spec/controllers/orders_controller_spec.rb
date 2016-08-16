require "rails_helper"

RSpec.describe OrdersController, :type => :controller do
  describe "GET #index" do
    it "renders the index template" do
      sign_in
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("index")
    end

    it "loads all the orders to @orders" do
      user = sign_in
      orders = [
        FactoryGirl.create(:order, user: user),
        FactoryGirl.create(:order, user: user)
      ]
      get :index
      expect(assigns(:orders)).to match_array(orders)
    end

    it "redirects to sign in page" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #show" do
    before(:each) do
      @user = sign_in
      @order = FactoryGirl.create(:order, user: @user)
    end

    it "renders the show template" do
      get :show, id: @order.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("show")
    end

    it "loads the correct order to @order in the controller" do
      get :show, id: @order.id
      expect(assigns(:order)).to match(@order)
    end

    it "raises an error" do
      order = FactoryGirl.create(:order)
      expect do
        get :show, id: order.id
      end.to raise_error('Wrong Owner')
    end
  end

  describe "GET #new" do
    it "renders the show template" do
      sign_in
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("new")
    end

    it "redirects to sign in page" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST #create" do
    it "saves the new order" do
      sign_in
      expect do
        post :create, order: FactoryGirl.attributes_for(:order)
      end.to change(Order, :count).by(1)
      expect(response).to redirect_to(orders_path)
    end

    it "redirects to sign in page" do
      expect do
        post :create, order: FactoryGirl.attributes_for(:order)
      end.to change(Order, :count).by(0)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
