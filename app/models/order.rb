class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy, :autosave => true#, :after_remove => :line_items_left
  belongs_to :address
  belongs_to :user, :inverse_of => :orders, :autosave => true
  
  attr_accessible :amount, :address_id, :user_id
  accepts_nested_attributes_for :line_items

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
      else
        false
      end
    end
  end

  scope :open_order, with_state(:open)
  scope :current_user_open_orders, lambda { |id| open_order.where(:user_id => id) }
  scope :user_orders, lambda { |id,state| where("user_id = ? AND state = ? ", id, state).order('updated_at desc ') }
  
  def self.current_user_open_order(id)
    order = current_user_open_orders(id).first
    if order
      order
    else
      create(:user_id => id)
    end
  end 

  
  def line_item_left(order)
    if order.line_items.empty?
      order.delete
    end
  end



end
