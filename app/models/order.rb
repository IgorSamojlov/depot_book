class Order < ActiveRecord::Base
  extend HumaniseMethod
  include Skope

  PAYMENT_TYPES = ['Check', 'Credit card', 'Purchase order']

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  has_many :line_items, dependent: :destroy
  add_methods :pay_type, :name

  def add_line_item_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def translete_attr(attr)
    I18n.t ("activerecord.attribute_values.order.#{attr}")
  end
end
