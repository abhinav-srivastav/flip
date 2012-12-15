class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories
  belongs_to :brand 
  attr_accessible :product, :product_type, :price, :category_ids, :brand_id
  accepts_nested_attributes_for :categories
end
