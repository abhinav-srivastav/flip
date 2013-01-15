class ProductAttribute < ActiveRecord::Base
  has_many :product_details, :dependent => :destroy, :autosave => true
  has_many :products, :through => :product_details  	
  belongs_to :prototype 
  attr_accessible :product_attributes, :product_details_attributes
  accepts_nested_attributes_for :product_details

  validates_presence_of :product_attributes
  validates :product_attributes, :uniqueness => true
end
