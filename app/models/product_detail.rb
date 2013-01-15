class ProductDetail < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_attribute
  attr_accessible :details, :product_id, :product_attribute_id

  validates_presence_of :details, :on => :update
  validates :product_attribute_id, :uniqueness => { :scope => :product_id  }
end