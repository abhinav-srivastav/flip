class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy, :autosave => true#, :before_remove => :update_order
  belongs_to :user
  attr_accessible :amount, :shipping_address, :user_id
  accepts_nested_attributes_for :line_items

  state_machine initial: :open do
  	event :book_order do
  		transition :open => :booked
  	end
    event :ship do
      transition :booked => :shipped
    end
    event :cancel do
      transition :booked => :cancel
    end    
  end

  scope :open_order, with_state(:open)
  scope :current_user_open_orders, lambda { |id| open_order.where(:user_id => id) }

  def self.current_user_open_order(id)
    current_user_open_orders(id).first
  end 
  
end
