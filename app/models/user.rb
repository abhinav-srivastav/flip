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
  
  # [FIXME_CR] No need to add users with below scopes
  # Thease are defined for a user itself.
  scope :normal_users, where(:super => false)

  # [FIXME_CR] use plural (super_users) instead of super_user. This will return a active relation. not a single record
  scope :super_user, where(:super => true).limit(1)
  private

  def self.super
    super_user.first
  end
  def self.authorize(username, password)
    user = User.find_by_username(username)
    return user if user && user.authenticate(password)
    nil
  end
end