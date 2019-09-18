class StoreController < ApplicationController
  skip_before_action :authorize

  include CurrentCart

  before_action :set_cart, only: %i(index)

  def index
  if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      if params[:get_locale]
        @products = Product.where(locale: params[:get_locale])
      else
        @products = Product.order(:title)
      end
    end
  end
end

