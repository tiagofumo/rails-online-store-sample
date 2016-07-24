class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_without_password(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :email)
    end
end
