class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :email, :wallet
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :email, uniqueness: true
  validates :wallet, :numericality => true
  private

  def self.authorize(username, password)
    user = User.find_by_username(username)
    return user if user && user.authenticate(password)
    nil
  end
end