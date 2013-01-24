class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable
  has_many :orders, :dependent => :destroy, :inverse_of => :user
  has_many :addresses, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  attr_accessible :username, :password, :admin, :super, :password_confirmation, :email, :wallet

  # has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, :if => :password
  validates :email, uniqueness: true
  validates :wallet, :numericality => { :greater_than => 0   }
  
  # [FIXME_CR] No need to add users with below scopes
  # Thease are defined for a user itself.
  scope :normals, where(:super => false)

  scope :supers, where(:super => true)

  def order_with_state(state)
    if state.nil? || state == 'open'
      orders.open_state
    else
      orders.with_state(state)
    end
  end

  def add_to_open_order(order_id)
    orders.open_state.add_line_item_from_order(order_id)
  end

  private

  def self.credit_to_admin(amount)
    admin = super_user
    admin.wallet += amount
    return true if admin.save
    return false     
  end

  def self.debit_from_admin(amount)
    admin = super_user
    admin.wallet -= amount
    return true if admin.save
    return false
  end

  def self.super_user
    supers.first
  end

end