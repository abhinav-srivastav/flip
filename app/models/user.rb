class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  extend FriendlyId
  friendly_id :username, use: :slugged
  devise :database_authenticatable, :registerable,
         :recoverable
  has_many :orders, :dependent => :destroy, :inverse_of => :user
  has_many :addresses, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_many :transactions
  attr_accessible :username, :password, :admin, :super, :password_confirmation, :email, :wallet

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, :if => :password
  validates :email, uniqueness: true
  validates :wallet, :numericality => { :greater_than => 0   }
  
  scope :normals, where(:super => false)

  scope :supers, where(:super => true)

  def order_with_state(state)
    if state.nil? || state == 'cart'
      orders.cart_state
    else
      orders.with_state(state)
    end
  end

  # [FIXME_CR] Need to discuss
  def add_to_cart(order_id)
    orders.cart_state.add_line_item_from_order(order_id)
  end

  def self.super_user
    supers.first
  end

end