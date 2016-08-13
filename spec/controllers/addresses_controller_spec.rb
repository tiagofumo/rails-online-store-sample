require "rails_helper"

RSpec.describe AddressesController, :type => :controller do
  describe "GET #index" do
    it "renders the index template" do
      sign_in
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("index")
    end

    it "loads all of the addresses into @addresses" do
      @user = sign_in
      addresses = [
        FactoryGirl.create(:address, user: @user),
        FactoryGirl.create(:address, user: @user)
      ]
      get :index
      expect(assigns(:addresses)).to match_array(addresses)
    end

    it "redirects to sign in page" do
      get :index

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #new" do
    it "renders the new template" do
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
    it "saves the new address" do
      sign_in
      expect do
        post :create, address: FactoryGirl.attributes_for(:address)
      end.to change(Address, :count).by(1)
      expect(response).to redirect_to(addresses_path)
    end

    it "redirects to sign in page" do
      expect do
        post :create, address: FactoryGirl.attributes_for(:address)
      end.to change(Address, :count).by(0)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET #edit' do
    it "renders the edit template" do
      @user = sign_in
      address = FactoryGirl.create(:address, user: @user)
      get :edit, id: address.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("edit")
    end

    it "raises an error" do
      address = FactoryGirl.create(:address)
      expect do
        get :edit, id: address.id
      end.to raise_error('Wrong Owner')
    end
  end

  describe "PATCH #update" do
    it "updates the address" do
      @user = sign_in
      address = FactoryGirl.create(:address, user: @user)
      address_params = FactoryGirl.attributes_for(:address, title: "CHANGED")
      patch :update, id: address.id, address: address_params
      expect(Address.find(address.id).title).to eq(address_params[:title])
      expect(response).to redirect_to(addresses_path)
    end

    it "raises error" do
      address = FactoryGirl.create(:address)
      address_params = FactoryGirl.attributes_for :address
      expect do
        patch :update, id: address.id, address: address_params
      end.to raise_error('Wrong Owner')
    end
  end

  describe "DELETE #destroy" do
    it "updates the address" do
      @user = sign_in
      address = FactoryGirl.create(:address, user: @user)
      delete :destroy, id: address.id
      expect(Address.where(id: address.id)).to eq([])
      expect(response).to redirect_to(addresses_path)
    end

    it "raises error" do
      address = FactoryGirl.create(:address)
      expect do
        delete :destroy, id: address.id
      end.to raise_error('Wrong Owner')
    end
  end
end
