class Brand < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :products
  attr_accessible :brand, :product_ids, :category_ids
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :products
end
