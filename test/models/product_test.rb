require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "the price" do
    product = Product.new(
      title: 'New',
      description: 'New',
      image_url: '1.jpg',
      price: 1
    )

    assert product.valid?
    product.price = -1

    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(img_url)
    Product.new(
      title: 'New',
      description: 'Des',
      price: 1,
      image_url: img_url
    )
  end

  test 'the img_url' do
    ok = %w{ fred.jpg fred.png fred.gif FRED.jpg FRED.png http://1.png }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} sholdn't be vald"
    end
  end
end
