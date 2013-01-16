class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :product, use: :slugged
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :prototypes
  has_many :line_items, :dependent => :destroy
  has_many :images, :dependent => :destroy, :autosave => true
  has_many :product_details, :dependent => :destroy
  has_many :product_attributes, :through => :product_details
  has_many :ratings, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  belongs_to :brand 
  attr_accessible :product, :cost_price, :price, :category_ids, :brand_id, :images_attributes, :product_attributes_attributes, :description, :available
  accepts_nested_attributes_for :product_attributes
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :images, :allow_destroy => true
  
  validates_presence_of :product, :price
  validates :description, :presence => true, :length => { :minimum => 50 }
  
  def add_details(pa_id)
    product_details.create(:product_attribute_id => pa_id)    
  end
end