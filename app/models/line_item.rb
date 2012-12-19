class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order, :autosave => true
  attr_accessible :product_id, :quantity, :price
end
