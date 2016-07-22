class StaticPagesController < ApplicationController
  def home
    @products = Product.includes(:primary_picture).
                        order(created_at: :desc).
                        limit(24)
  end

  def about
  end
end
