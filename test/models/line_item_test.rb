require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  test 'valid the line item' do
    product = products :ruby
    lineitem = LineItem.new product_id: product.id, price: product.price
    assert lineitem.valid?
    assert lineitem.price == 9.99
  end
end
