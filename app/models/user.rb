class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { maximum:30 }
  validates :email, presence: true, length: { maximum:255 }
  validates :password, presence: true, length: { minimum: 6 }
  before_validation { email.downcase! }
  before_destroy :block_destroy
  has_secure_password

  private
  def block_destroy
    @users = User.where(admin: true)
    if @users.count == 1
    raise
    end
  end
end
