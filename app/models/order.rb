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
      if order.can_be_booked?
        order.user.debit(order.amount)
        order.line_items.decrement_available_quantity
        Notifier.booking(order).deliver
      else
        false
      end
    end

    before_transition :booked => :cancel do |order|
      order.user.credit(order.amount)
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
  # scope :to_be_dispatched, lambda { where('updated_at < ? and state = ?', Time.now-2.hours, :booked) }


  before_save :update_order_amount, :add_overhead_charges

  def merge_line_item_from_order(anonymous_cart)
    anonymous_cart.line_items.each do |li|
      add_line_item(li.varient_id, li.price, li.quantity)
    end 
    anonymous_cart.destroy
  end

  def add_line_item(varient_id, varient_price, varient_quantity = 1)
    if li = line_items.find_by_varient_id(varient_id) 
      li.quantity += varient_quantity
      li.save
    else
      line_items.create(:varient_id => varient_id, :price => varient_price, :quantity => varient_quantity)
    end
  end

  def can_be_booked?
    amount > 0 && amount <= user.wallet && address
  end
  private
    def update_order_amount
      self.amount = self.line_items.sum('price * quantity').to_i
    end

    def add_overhead_charges
      self.amount += SHIPPING_CHARGES if self.line_items.any?
    end


  # def self.dispatch(time)
  #   booked = Order.to_be_dispatched(time)
  #   booked.each do |order|
  #     order.dispatch
  #     Notifier.dispatched(order).deliver   
  #   end
  # end 
end