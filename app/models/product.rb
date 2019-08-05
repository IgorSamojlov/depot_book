class Product < ActiveRecord::Base
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'URL должен указывать на изображение формата GIF, JPG или PNG.'
}
  has_many :line_items

  before_destroy :ensure_notreferenced_by_any_line_item

  def ensure_notreferenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Существуют товарные позиции')
      return false
    end
  end

  def self.latest
    Product.order(:updated_at).last
  end


end
