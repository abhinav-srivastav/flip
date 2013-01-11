class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :product, use: :slugged
  has_and_belongs_to_many :categories
  has_many :line_items, :dependent => :destroy
  has_many :images, :dependent => :destroy, :autosave => true
  has_many :product_details, :dependent => :destroy
  has_many :product_attributes, :through => :product_details
  belongs_to :brand 
  attr_accessible :product, :product_type, :cost_price, :price, :category_ids, :brand_id, :images_attributes, :product_attributes_attributes
  accepts_nested_attributes_for :product_attributes
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :images, :allow_destroy => true
end
