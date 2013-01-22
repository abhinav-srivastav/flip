class Prototype < ActiveRecord::Base
  has_and_belongs_to_many :product_attributes
  has_and_belongs_to_many :products
  attr_accessible :name, :product_attribute_ids
  accepts_nested_attributes_for :product_attributes
  
  validates :name, :presence => true, :uniqueness => true

  def add_attributes_to_product(product_id)
    product = Product.find(params[:product_id])
    products << product
    product_attributes.each do |pa|
      product.add_details(pa.id)
    end
  end
end