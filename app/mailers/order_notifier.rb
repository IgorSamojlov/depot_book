class OrderNotifier < ApplicationMailer
  default from: 'Sam Ruby <depot@example.com>'

  def received(order)
    @order = order

    mail to: order.email, subject: 'Подтверждение заказа'
  end

  def shipped(order)
    @order = order

    mail to: order.email, subject: 'Заказ отправлен'
  end
end
