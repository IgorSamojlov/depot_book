module StoreHelper
  def how_much_get_index
    session[:store_index_counter] ||= 1
    session[:store_index_counter] += 1
  end
end
