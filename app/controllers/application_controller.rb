class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :load_user, :load_categories, :load_cart_size

  private
    def load_user
      if user_signed_in? then
        @current_user = current_user
      end
    end

    def load_categories
      @categories = Category.all.order :name
    end

    def load_cart_size
      if user_signed_in?
        @cart_size = CartItem.where(user_id: @current_user).sum(:quantity)
      else
        @cart_size = 0
      end
    end
end
