class User < ActiveRecord::Base
  has_many :orders, :dependent => :destroy, :inverse_of => :user
  has_many :addresses, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  attr_accessible :username, :password, :admin, :super, :password_confirmation, :email, :wallet

  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, :if => :password
  validates :email, uniqueness: true
  validates :wallet, :numericality => { :greater_than => 0   }
  
  scope :normal_users, where(:super => false)
  scope :super_users, where(:super => true)
  private

  def self.credit_to_admin(amount)
    admin = super_user
    admin.wallet += amount
    return true if admin.save
    return false     
  end

  def debit_from_admin(amount)
    admin = super_user
    admin.wallet -= amount
    return true if admin.save
    return false
  end

  def self.super_user
    super_users.first
  end
  def self.authorize(username, password)
    user = User.find_by_username(username)
    return user if user && user.authenticate(password)
    nil
  end
end