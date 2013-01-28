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
        # [FIXME_CR] Here we are substructing amount from user not from the order. So it should be something like debit_user or somtehing more appropriate
        # Please lets discuss this
        order.debit(order.amount, order.user)
        order.line_items.decrement_available_quantity
        Notifier.booking(order).deliver
      else
        false
      end
    end

    before_transition :booked => :cancel do |order|
      # [FIXME_CR] similar a debit and before_transition 
      order.credit(order.amount, order.user)
      order.line_items.return_quantity_to_varient
      Notifier.cancellation(order).deliver  
    end
    after_transition :booked => :dispatched do |order|
      Notifier.dispatched(order).deliver  
    end
    after_transition :dispatched => :delivered do |order|
      Notifier.delivered(order).deliver  
    end
  end
  
  # [FIXME_CR] Time.now will return server's time.
  # Please use Time.current (Time.zone.now)
  scope :to_be_dispatched, lambda { where('updated_at < ? and state = ?', Time.now-2.hours, :booked) }

  # [FIXME_CR] Lets use a cleaner approach here. Please extract code under before_save into a private method. 
  # and use before_save :newly_created_private_method (e.g calculate_total_amount).
  # 
  before_save do |order|
    order.amount = 0
    # [FIXME_CR] item.price * item.quantity belongs to line_item. So, we should move this to line_item
    # Also, this can be written as somthing like line_items.collect(&:total).sum
    order.line_items.each do |item|
      order.amount += item.price * item.quantity
    end

    # [FIXME_CR] Not sure why we are adding this to an order. shipping or processing changes?
    order.amount += 30 if order.line_items.any? 
  end

  def debit(amount,user)
    # [FIXME_CR] Below mentioned two lines will be nedded all the time if we are creating a debit transaction.
    # if we move user.wallet -= amount to before/after create callback then this is not needed.
    # Lets also include a reason for the transaction ("Bought Order#XXXXXXXXXX")
    user.wallet -= amount
    transactions.create(:transaction_type => 'debit',:amount => amount,:user_id => user_id)
  end

  def credit(amount,user)
    # [FIXME_CR] Similar to debit.
    user.wallet += amount
    transactions.create(:transaction_type => 'credit',:amount => amount,:user_id => user_id)
  end


  # [FIXME_CR] Need to discuss why we have defined this and add_line_item.
  #  
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
    # [FIXME_CR] The below mentioned line will return either true or false. So there is no need to add if.
    # Only amount > 0 && amount <= user.wallet && address will work
    # And here we are checking if an order can be completed or not. Not the order is complete or not
    # So, we should rebname this method to an appropriate name ()
    return true if amount > 0 && amount <= user.wallet && address
    false
  end

  # # [FIXME_CR] unused metghod
  def self.dispatch(time)
    booked = Order.to_be_dispatched(time)
    booked.each do |order|
      order.dispatch
      Notifier.dispatched(order).deliver   
    end
  end 
end