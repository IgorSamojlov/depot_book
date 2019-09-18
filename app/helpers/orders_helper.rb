module OrdersHelper
  def get_translete
    transl = I18n.t 'activerecord.attribute_values.order.pay_type'
    Order::PAYMENT_TYPES.map do |el| [(transl.is_a? Hash) && transl[el.to_sym] || el, el]
    end
  end
end
