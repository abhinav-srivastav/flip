class LineItem < ActiveRecord::Base
  belongs_to :varient
  belongs_to :order, :autosave => true
  attr_accessible :varient_id, :quantity, :price

  validates :quantity, :numericality => { :greater_than => 0 }
  validates :price, :presence => true, :numericality => true

  def decrement_available_quantity
     varient.available -= quantity
     varient.save
  end

  def decrement_available_quantity
    varient.available += quantity
    varient.save
  end
end
