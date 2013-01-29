class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  extend FriendlyId
  friendly_id :username, use: :slugged
  devise :database_authenticatable, :registerable,
         :recoverable
  has_many :orders, :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_many :transactions
  attr_accessible :username, :password, :admin, :super, :password_confirmation, :email, :wallet

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, :if => :password
  validates :email, uniqueness: true
  validates :wallet, :numericality => { :greater_than => 0 }
  
  scope :normals, where(:super => false)

  scope :supers, where(:super => true)

  def order_with_state(state)
    case state
    when 'booked','cancel','dispatched','delivered'
      orders.with_state(state)
    else
      orders.with_state('booked')
    end
  end

  def cart
    unless order = orders.with_state('cart').first
      order = orders.create
    end
    order
  end

  def merge_to_my_cart(anonymous_order)
    cart.merge_line_item_from_order(anonymous_order)
  end

  def self.super_user
    supers.first
  end

  def debit(amount)
    transactions.create(:transaction_type => 'debit',:amount => amount)
  end

  def credit(amount)
    transactions.create(:transaction_type => 'credit',:amount => amount)
  end
end