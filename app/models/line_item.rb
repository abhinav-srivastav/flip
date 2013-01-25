class LineItem < ActiveRecord::Base
  belongs_to :varient
  belongs_to :order, :autosave => true
  attr_accessible :varient_id, :quantity, :price

  validates :quantity, :numericality => { :greater_than => 0 }, :inclusion => { :in => lambda { |line_item| 0..(line_item.varient.available) } }
  validates :price, :presence => true, :numericality => true
  validates :varient_id, :presence => true

  around_destroy do |line_item, block|
    order = line_item.order
    block.call
    order.save if order 
  end 

  after_save do |line_item|
    line_item.order.save
  end

  def change_order_id(changed_order_id)
    order_id = changed_order_id
  end


  def decrement_available_quantity
     varient.available -= quantity
     varient.save
  end

  def return_quantity_to_varient
    varient.available += quantity
    varient.save
  end
end
