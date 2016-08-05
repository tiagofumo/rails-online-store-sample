class OrdersController < ApplicationController
  before_action :login_needed, only: [:index, :new, :create]
  before_action :set_order_and_check_ownership, only: [:show]

  def index
    @orders = Order.includes(:order_items, :shipping_method).all
  end

  def show
    @order = Order.includes({order_items: [product: [:primary_picture]]},
                            :shipping_method, :address).find(params[:id])
  end

  def new
    login_needed
    @order = Order.new
    @addresses = Address.where user_id: @current_user.id
    @cart_items = CartItem.where user_id: @current_user.id
    @shipping_methods = ShippingMethod.all
  end

  def edit
  end

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

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_order_and_check_ownership
      @order = Order.find(params[:id])
      check_ownership(@order.user_id)
    end

    def order_params
      params.require(:order).permit(:address_id, :shipping_method_id)
    end
end
