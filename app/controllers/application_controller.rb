class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :load_user, :load_cart_size

  protected
    def login_needed
      if !user_signed_in?
        redirect_to new_user_session_path, alert: 'Please log in.'
      end
    end

    def check_ownership(user_id = params[:id])
      if !user_signed_in? || @current_user.id != user_id
        page_not_found("Wrong Owner")
      end
    end

    def page_not_found(message = 'Not Found')
      raise ActionController::RoutingError.new(message)
    end
  private
    def load_user
      if user_signed_in? then
        @current_user = current_user
      end
    end

    def load_cart_size
      if user_signed_in?
        @cart_size = CartItem.where(user_id: @current_user).sum(:quantity)
      else
        @cart_size = 0
      end
    end
end
