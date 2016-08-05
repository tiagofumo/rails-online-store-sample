class AddressesController < ApplicationController
  before_action :login_needed, only: [:index, :new, :create]
  before_action :set_address_and_check, only: [:show, :edit, :update, :destroy]

  def index
    @addresses = Address.where(user_id: @current_user.id)
  end

  def show
  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    @address = Address.new(address_params)
    @address.user_id = @current_user.id

    respond_to do |format|
      if @address.save
        format.html { redirect_to addresses_path }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to addresses_path }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url }
      format.json { head :no_content }
    end
  end

  private
    def address_params
      params.require(:address).permit(:title, :receiver, :company, :street,
                                      :street_extra, :city, :postal_code,
                                      :state, :country, :phone)
    end

    def set_address_and_check
      @address = Address.find(params[:id])
      check_ownership(@address.user_id)
    end
end
