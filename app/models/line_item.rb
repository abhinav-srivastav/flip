class LineItem < ActiveRecord::Base

  # [FIXME_CR] Validations on product_id, quantity, price, order_id ?

  belongs_to :product
  belongs_to :order, :autosave => true
  attr_accessible :product_id, :quantity, :price

  validates :quantity, :numericality => { :greater_than => 0 }
  
  # [FIXME_CR] Rename method to a more appropriate name ie. decrement_available_quantity
  def decrement_available
     product.available -= quantity
     product.save
  end
end
