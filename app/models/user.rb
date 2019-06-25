class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { maximum:30 }
  validates :email, presence: true, length: { maximum:255 }
  validates :password, presence: true, length: { minimum: 6 }
  before_validation { email.downcase! }
  before_destroy :block_delete_last_admin
  has_secure_password

  private
  def block_delete_last_admin
    raise if User.where(admin: true).count == 1
  end
end
