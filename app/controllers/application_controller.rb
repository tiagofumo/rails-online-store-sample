class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :load_user, :load_categories

  private
    def load_user
      if user_signed_in? then
        @current_user = current_user
      end
    end

    def load_categories
      @categories = Category.all.order :name
    end
end
