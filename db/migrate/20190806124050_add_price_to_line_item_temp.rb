class AddPriceToLineItemTemp < ActiveRecord::Migration
  def change
    LineItem.all.each do |item|
      if item.quantity > 1
        item.price = item.product.price * item.quantity
      else
        item.price = item.product.price
      end
      item.save!
    end
  end
end
