class LineItem < ActiveRecord::Base
  belongs_to :varient
  belongs_to :order, :autosave => true
  attr_accessible :varient_id, :quantity, :price

  validates :quantity, :numericality => { :greater_than => 0 }
  
  def decrement_available
     varient.available -= quantity
     varient.save
  end
end
