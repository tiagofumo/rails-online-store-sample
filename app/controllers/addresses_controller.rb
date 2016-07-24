class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.where(user_id: @current_user.id)
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
    check_ownership(@address.user_id)
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
    check_ownership(@address.user_id)
  end

  # POST /addresses
  # POST /addresses.json
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

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    check_ownership(@address.user_id)
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

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    check_ownership(@address.user_id)
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:title, :receiver, :company, :street,
                                      :street_extra, :city, :postal_code,
                                      :state, :country, :phone)
    end
end
