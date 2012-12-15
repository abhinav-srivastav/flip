class Category < ActiveRecord::Base
  has_and_belongs_to_many :brands
  has_and_belongs_to_many :products

  attr_accessible :category, :visible, :product_ids, :brand_ids
  
  accepts_nested_attributes_for :products
  accepts_nested_attributes_for :brands
  
  scope :visible, where(:visible => true)
end
