class Attribute < ActiveRecord::Base
  has_many :product_details
  has_many :products, :through => :product_details  	
  attr_accessible :product_attributes
end
