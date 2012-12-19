class User < ActiveRecord::Base
  has_many :order, :dependent => :destroy
  attr_accessible :username, :password, :admin, :super, :password_confirmation, :email, :wallet
  # attr_accessor :modified
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, :if => :password
  validates :email, uniqueness: true
  validates :wallet, :numericality => true
  
  scope :super, where(:super => false)

  private
  # def check_if_admin?
  #   logger.info(modified)
  #   logger.info('sfvv')
  #   if modified 
  #     return false
  #   end
  #   true
  # end

  def self.authorize(username, password)
    user = User.find_by_username(username)
    return user if user && user.authenticate(password)
    nil
  end
end