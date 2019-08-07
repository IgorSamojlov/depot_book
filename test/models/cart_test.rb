require 'test_helper'

class CartTest < ActiveSupport::TestCase
  setup do
    @cart = carts :one
    @product = products :ruby
    @product_with_our_price = products :two
  end

  test 'the add product to cart' do
    line_item = @cart.add_product @product.id
    assert @cart.valid?
    assert 9.99 == line_item.price
    line_item.save!
    new_line_item = @cart.add_product @product_with_our_price.id
    assert @cart.total_price == 109.99
  end
end
