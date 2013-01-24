class Order < ActiveRecord::Base

  has_many :line_items, :dependent => :destroy, :autosave => true
  belongs_to :address
  belongs_to :user, :inverse_of => :orders, :autosave => true
  
  attr_accessible :amount, :address_id, :user_id
  validates :amount , :presence => true, :numericality => true
  validates :address_id , :presence => true, :if => :booked?
  validates :user_id , :presence => true, :unless => :open?

  accepts_nested_attributes_for :line_items

  # [FIXME_CR] Use a more appropriate name for order states
  # While order is in cart state its status should be somthing like cart or any other more appropriate name
  # As soon as user completes order, its status should be new/pending
  state_machine initial: :open do
  	event :pay do
  		transition :open => :booked
  	end
    event :dispatch do
      transition :booked => :dispatched
    end
    event :cancel do
      transition :booked => :cancel
    end    
    event :deliver do
      transition :dispatched => :delivered
    end
  
    before_transition :open => :booked do |order|
      if  order.amount > 0 && order.amount <= order.user.wallet && order.address
        order.user.wallet -= order.amount
        User.credit_to_admin(order.amount)
        order.line_items.each do |li|
          li.decrement_available_quantity
        end
      else
        false
      end
    end

    before_transition :booked => :cancel do |order|
      order.user.wallet += order.amount
      User.debit_from_admin(order.amount)
      order.line_items.each do |line|
        line.return_quantity_to_varient
      end
    end
  end

<<<<<<< HEAD
  scope :user_orders, lambda { |id,state| where("user_id = ? AND state = ? ", id, state).order('updated_at desc ') }
  scope :to_be_dispatched, lambda { |time| where('updated_at < ? and state = ?', time, :booked) }

  around_save do |order, block|
    order.amount = 0
    order.line_items.each do |item|
      order.amount += item.price * item.quantity
      order.amount += 30
    end
    block.call
  end

  def self.open_state
    order = with_state('open').first
    unless order
      order = new
    end
    order
  end

<<<<<<< HEAD
  def add_line_item(varient_id, varient_price)
    li = line_items.find_by_varient_id(varient_id)
    if li.nil?
      line_items.new(:varient_id => varient_id, :price => varient_price)
    end
  end

  def self.dispatch(time)
    booked = Order.to_be_dispatched(time)
    booked.each do |order|
      order.dispatch
    end
  end

  def self.user_order(user_id,state)
    order = user_orders(user_id,state).first
    if order
      order
    else
      create(:user_id => user_id)
    end
  end 
end