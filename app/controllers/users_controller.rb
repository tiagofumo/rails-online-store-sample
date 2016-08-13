class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if !user_signed_in? || current_user.id != @user.id
      raise ActionController::RoutingError.new("Wrong user.")
      return
    end
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def profile
    login_needed
  end

  def update_profile
    login_needed
    user_params = params.require(:user).permit(:alias, :avatar,
                                               :country, :profile)
    @current_user.update_without_password(user_params)
    redirect_to :profile
  end

  def account
    login_needed
  end

  def update_account
    login_needed
    user_params = params.require(:user).permit(:name, :company,
                                               :phone, :fax)
    @current_user.update_without_password(user_params)
    redirect_to :account
  end

  def edit_password
    login_needed
  end

  def update_password
    login_needed
    user_params = params.require(:user).permit(:password, :password_confirmation)
    if @current_user.valid_password? params.require(:user)[:old_password]
      if @current_user.update_with_password user_params
        sign_in @current_user, bypass: true
        redirect_to :account
      else
        redirect_to account_password_path, alert: 'Error while updating password.'
      end
    else
      redirect_to account_password_path, alert: 'Your inserted the wrong password.'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :password, :email)
    end
end
