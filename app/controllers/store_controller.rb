class StoreController < ApplicationController
  before_action :how_much_get_index, only: [:index]

  def index
    @products = Product.order(:title)
  end

  def how_much_get_index
    @index_counter = session[:store_index_counter] || 0
    session[:store_index_counter] = @index_counter + 1
  end
end
