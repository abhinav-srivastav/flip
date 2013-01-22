class Order < ActiveRecord::Base

  # [FIXME_CR] Validations?

  has_many :line_items, :dependent => :destroy, :autosave => true
  belongs_to :address
  belongs_to :user, :inverse_of => :orders, :autosave => true
  
  attr_accessible :amount, :address_id, :user_id
  accepts_nested_attributes_for :line_items

  # [FIXME_CR] Use a more appropriate name for order states
  # While order is in cart state its status should be somthing like cart or any other more appropriate name
  # As soon as user completes order, its status should be new/pending
  # There should be  atleast one more status named delivered.
  # On order cancellation inventory should be increased.
  #
  state_machine initial: :open do
  	event :pay do
  		transition :open => :booked
  	end
    event :ship do
      transition :booked => :shipped
    end
    event :cancel do
      transition :booked => :cancel
    end    
  
    before_transition :open => :booked do |order|
      if  order.amount > 0 && order.amount <= order.user.wallet && order.address
        order.user.wallet -= order.amount
        order.line_items.each do |li|
          li.decrement_available
        end
      else
        false
      end
    end
  end

  # [FIXME_CR] This should be open_orders instead of open_order because this returns an active relation not a single record
  scope :open_order, with_state(:open)

  # [FIXME_CR] Should be a part of User Model and argument should not be 'id'. It should be user_id
  # has_many :orders (already defined).
  scope :current_user_open_orders, lambda { |id| open_order.where(:user_id => id) }

  # [FIXME_CR] user_orders should be a part of User Model as mentioned above.
  # And 
  scope :user_orders, lambda { |id,state| where("user_id = ? AND state = ? ", id, state).order('updated_at desc ') }

  # [FIXME_CR] Invalid defination. lambda must be used. Time.now will evaluate to the time of code load.
  # Actually it should be dynamic. But, here it is not
  scope :to_be_shipped, where('updated_at < ? and state = ?', Time.now-2.hours, :booked)


  # [FIXME_CR] unused method. No need to pass order in argument
  # Also this method is deleting order if order.line_items.empty?
  # name of this method is not appropriate.
  def line_item_left(order)
    if order.line_items.empty?
      order.delete
    end
  end

  def self.dispatch_shipment
    booked = Order.to_be_shipped
    booked.each do |order|
      order.ship
    end
  end

  # [FIXME_CR] Should be a part of User Model and argument should not be 'id'. It should be user_id
  # current_user.open_order
  def self.current_user_open_order(id)
    order = current_user_open_orders(id).first
    if order
      order
    else
      create(:user_id => id)
    end
  end 
end