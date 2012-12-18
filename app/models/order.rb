class Order < ActiveRecord::Base
  has_many :line_items 
  belongs_to :user
  attr_accessible :amount, :shipping_address
  accepts_nested_attributes_for :line_items
end
