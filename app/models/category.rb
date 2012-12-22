class Category < ActiveRecord::Base
  acts_as_tree
  extend FriendlyId

  friendly_id :category, use: :slugged
  has_and_belongs_to_many :brands
  has_and_belongs_to_many :products

  attr_accessible :category, :visible, :product_ids, :brand_ids, :parent_id
  
  accepts_nested_attributes_for :products
  accepts_nested_attributes_for :brands
  
  scope :visible, where(:visible => true)
  scope :root, visible.where(:parent_id => nil)
end
