class Order < ActiveRecord::Base

  has_many :line_items, :dependent => :destroy, :autosave => true
  has_many :transactions, :autosave => true
  belongs_to :address
  belongs_to :user, :inverse_of => :orders, :autosave => true
  
  attr_accessible :amount, :address_id, :user_id
  validates :amount , :presence => true, :numericality => true
  validates :address_id , :presence => true, :if => :booked?
  validates :user_id , :presence => true, :unless => :cart?

  accepts_nested_attributes_for :line_items
  # As soon as user completes order, its status should be new/pending
  state_machine initial: :cart do
  	event :pay do
  		transition :cart => :booked
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

    before_transition :cart => :booked do |order|
      if order.complete?
        order.debit(order.amount, order.user)
        order.line_items.each do |li|
          li.decrement_available_quantity
        end
        Notifier.booking(order).deliver
      else
        false
      end
    end

    before_transition :booked => :cancel do |order|
      order.credit(order.amount, order.user)
      order.line_items.each do |line|
        line.return_quantity_to_varient
      end
       Notifier.cancellation(order).deliver  
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

  def debit(amount,user)
    user.wallet -= amount
    transactions.create(:transaction_type => 'debit',:amount => amount,:user_id => user_id)
  end

  def credit(amount,user)
    user.wallet += amount
    transactions.create(:transaction_type => 'credit',:amount => amount,:user_id => user_id)
  end


  def add_line_item_from_order(cart_id)
    cart = Order.find(cart_id)
    cart.line_items.each do |li|
      add_line_item(li.varient_id, li.price, li.quantity)
    end 
    cart.destroy
  end

  def self.cart_state
    unless order = with_state('cart').first
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

  def complete?
    return true if amount > 0 && amount <= user.wallet && address
    false
  end

  def self.dispatch(time)
    booked = Order.to_be_dispatched(time)
    booked.each do |order|
      order.dispatch
    end
  end 
end