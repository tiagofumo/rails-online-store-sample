class CartItemsController < ApplicationController
  def index
    if user_signed_in?
      @cart_items = CartItem.where(user_id: @current_user.id).
                             includes(product: :primary_picture)
    else
      @cart_items = []
    end
  end

  def create
    success = false
    if user_signed_in?
      items = CartItem.where(user_id: @current_user.id,
                             product_id: params[:product_id])
      if items.empty?
        success = CartItem.create user_id: @current_user.id,
                                 product_id: params[:product_id],
                                 quantity: params[:quantity] || 1
      else
        item = items.first
        item.quantity += params[:quantity].to_i || 1
        success = item.save
      end
    end
    qty = CartItem.where(user_id: @current_user).sum(:quantity)
    render json: { success: success, cart_quantity: qty }
  end

  def destroy
    success = false
    if user_signed_in?
      if params[:id] && (item = CartItem.find_by id: params[:id]) &&
                        item.user_id == @current_user.id
        success = item.destroy
      end
    end
    render json: { success: success }
  end
end
