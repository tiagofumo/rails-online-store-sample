require "rails_helper"

RSpec.describe UsersController, :type => :controller do
  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    it "creates the user" do
      user_params = FactoryGirl.attributes_for(:user)
      expect do
        post :create, user: user_params
      end.to change(User, :count).by(1)
    end

    it "redirects to root_url" do
      user_params = FactoryGirl.attributes_for(:user)
      post :create, user: user_params
      expect(response).to redirect_to(root_url)
    end
  end

  describe "GET #show" do
    it "renders the show page" do
      user = FactoryGirl.create(:user)
      get :show, id: user
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("show")
    end

    it "matches the requested user" do
      user = FactoryGirl.create(:user)
      get :show, id: user
      expect(assigns(:user)).to match(user)
    end
  end

  describe "GET #profile" do
    it "renders the profile template" do
      sign_in
      get :profile
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("profile")
    end

    it "redirects to sign in page" do
      get :profile
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "PATCH #update_profile" do
    it "updates the user profile fields" do
      user = sign_in
      user_params = { alias: 'alias', country: 'BR', profile: 'profile' }
      patch :update_profile, user: user_params
      user = User.find(user.id)
      user_params.each { |key, val| expect(user.send(key)).to eq(val) }
    end

    it "redirects to sign in page" do
      user_params = { alias: 'alias', country: 'BR', profile: 'profile' }
      patch :update_profile, user: user_params
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #account" do
    it "renders the account template" do
      sign_in
      get :account
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("account")
    end

    it "redirects to sign in page" do
      get :account
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "PATCH #update_account" do
    it "updates the user account fields" do
      user = sign_in
      user_params = { name: 'new name', company: 'new company',
                      phone: '123456', fax: '789456456'}
      patch :update_account, user: user_params
      user = User.find(user.id)
      user_params.each { |key, val| expect(user.send(key)).to eq(val) }
    end

    it "redirects to sign in page" do
      user_params = { alias: 'alias', country: 'BR', profile: 'profile' }
      patch :update_account, user: user_params
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #edit_password" do
    it "renders the edit_password template" do
      sign_in
      get :edit_password
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("edit_password")
    end

    it "redirects to sign in page" do
      get :edit_password
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "PATCH #update_password" do
    it "updates the user password" do
      user = sign_in
      new_password = '123456'
      user_params = { current_password: user.password, password: new_password,
                      password_confirmation: new_password}
      patch :update_password, user: user_params
      expect(User.find(user.id).valid_password?(new_password)).to be true
    end

    it "redirects to sign in page" do
      user = FactoryGirl.create(:user)
      new_password = '123456'
      user_params = { current_password: user.password, password: new_password,
                      password_confirmation: new_password}
      patch :update_password, user: user_params
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the user" do
      user = sign_in
      expect do
        delete :destroy, id: user.id
      end.to change(User, :count).by(-1)
    end

    it "raises error" do
      user = FactoryGirl.create(:user)
      expect do
        delete :destroy, id: user.id
      end.to raise_error('Wrong user.')
    end
  end
end
