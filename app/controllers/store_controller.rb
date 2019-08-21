class StoreController < ApplicationController
  skip_before_action :authorize

  include CurrentCart

  before_action :how_much_get_index, :set_cart, only: %i(index)

  def index
    @products = Product.order(:title)
  end

  def how_much_get_index
    @index_counter = session[:store_index_counter] || 0
    session[:store_index_counter] = @index_counter + 1
  end
end
