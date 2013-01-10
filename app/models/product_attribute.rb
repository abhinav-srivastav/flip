class ProductAttribute < ActiveRecord::Base
  has_many :product_details, :dependent => :destroy
  has_many :products, :through => :product_details  	
  attr_accessible :product_attributes, :product_details_attributes
  accepts_nested_attributes_for :product_details
end
