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

  scope :to_be_dispatched, lambda { where('updated_at < ? and state = ?', Time.now-2.hours, :booked) }

  before_save do |order|
    order.amount = 0
    order.line_items.each do |item|
      order.amount += item.price * item.quantity
    end
    order.amount += 30 if order.line_items.any? 
  end

  def add_line_item_from_order(cart_id)
    cart = Order.find(cart_id)
    cart.line_items.each do |li|
      add_line_item(li.varient_id, li.price, li.quantity)
    end 
    cart.destroy
  end

  def self.open_state
    unless order = with_state('open').first
      order = create
    end    
    order
  end

  def add_line_item(varient_id, varient_price, order_quantity = 1)
    if li = line_items.find_by_varient_id(varient_id) 
      li.quantity += order_quantity
      li.save
    else
      line_items.create(:varient_id => varient_id, :price => varient_price, :quantity => order_quantity)
    end
  end

  def self.dispatch(time)
    booked = Order.to_be_dispatched(time)
    booked.each do |order|
      order.dispatch
    end
  end 

end