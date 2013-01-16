class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order, :autosave => true
  attr_accessible :product_id, :quantity, :price

  validates :quantity, :numericality => { :greater_than => 0 }
  
  def decrement_available
     product.available -= quantity
     product.save
  end
end
