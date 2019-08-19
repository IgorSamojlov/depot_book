require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  test 'Bay product' do
    LineItem.delete_all
    Order.delete_all

    ruby = products(:ruby)

    get '/'
    assert_response :success
    assert_template 'index'

    xml_http_request :post, '/line_items', product_id: ruby.id
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby, cart.line_items[0].product

    get '/orders/new'
    assert_response :success
    assert_template 'new'

    post_via_redirect '/orders',
      order: {name: 'Dave Thomas',
              address: '123 The Street',
              email: 'dave@example.com',
              pay_type: 'Check'}

    assert_response :success

    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    assert_equal 'Dave Thomas', order.name
    assert_equal '123 The Street', order.address
    assert_equal 'dave@example.com', order.email
    assert_equal 'Check', order.pay_type

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby, line_item.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal ['dave@example.com'], mail.to
    assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
    assert_equal 'Подтверждение заказа', mail.subject
  end

end
