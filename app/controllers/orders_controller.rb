class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.includes(:order_items, :shipping_method).all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    login_needed
    @order = Order.new
    @addresses = Address.where user_id: @current_user.id
    @cart_items = CartItem.where user_id: @current_user.id
    @shipping_methods = ShippingMethod.all
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    login_needed
    @order = Order.new(order_params)
    @order.user_id = @current_user.id
    @order.status = :new_order
    @cart_items = CartItem.includes(:product).where user_id: @current_user.id
    @order.transaction do
      @order.save!
      @cart_items.each do |cart_item|
        OrderItem.create price: cart_item.product.price,
                         quantity: cart_item.quantity,
                         product_id: cart_item.product_id,
                         order_id: @order.id
      end
      CartItem.delete_all user_id: @current_user.id
    end
    respond_to do |format|
      if @order.id
        format.html { redirect_to orders_path, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:address_id, :shipping_method_id)
    end
end
