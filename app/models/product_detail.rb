class ProductDetail < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_attribute
  attr_accessible :details, :product_id
end
