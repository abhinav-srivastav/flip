class LineItem < ActiveRecord::Base
  belongs_to :varient
  belongs_to :order, :autosave => true
  attr_accessible :varient_id, :quantity, :price

  validates :quantity, :numericality => { :greater_than => 0 }, :inclusion => { :in => lambda { |line_item| 0..(line_item.varient.available) } }
  validates :price, :presence => true, :numericality => true
  validates :varient_id, :presence => true

  # before_save do |line_item|

  # end



  def decrement_available_quantity
     varient.available -= quantity
     varient.save
  end

  def return_quantity_to_varient
    varient.available += quantity
    varient.save
  end
end
