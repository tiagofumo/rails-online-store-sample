class CartController < ApplicationController
  def index
    if user_signed_in?
      @cart_items = CartItem.where(user_id: @current_user.id).
                             includes(product: :primary_picture)
    else
      @cart_items = []
    end
  end

  def add_item
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
    render json: { success: success }
  end

  def destroy_item
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
