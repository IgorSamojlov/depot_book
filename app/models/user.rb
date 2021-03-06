class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: {maximum: 5}
  validates :password, length: {maximum: 6}
  has_secure_password

  include Skope

  after_destroy :ensure_an_admin_remains

  def ensure_an_admin_remains
    if User.count.zero?
      raise 'Последниий админ не может быть удален'
    end
  end
end
