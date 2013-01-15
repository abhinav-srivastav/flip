class Prototype < ActiveRecord::Base
  has_many :product_attributes
  has_and_belongs_to_many :products
  attr_accessible :name, :product_attribute_ids
  accepts_nested_attributes_for :product_attributes
end