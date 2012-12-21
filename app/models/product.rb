class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :product, use: :slugged
  has_and_belongs_to_many :categories
  has_many :line_items, :dependent => :destroy
  has_many :images, :dependent => :destroy, :autosave => true
  belongs_to :brand 
  attr_accessible :product, :product_type, :price, :category_ids, :brand_id, :images_attributes
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :images, :allow_destroy => true
end
