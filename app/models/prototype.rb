class Prototype < ActiveRecord::Base
  has_and_belongs_to_many :product_attributes
  has_and_belongs_to_many :products
  attr_accessible :name, :product_attribute_ids
  accepts_nested_attributes_for :product_attributes
  
  validates :name, :presence => true, :uniqueness => true

  def add_attributes_to_product(product_id)
    product = Product.find(product_id)
    products << product
    add_attribute(product)
  end

  def product_attribute_update
    products.each do |product|
      add_attribute(product)
    end 
  end
  def add_attribute(product)
    product_attributes.each do |product_attr|
      product.add_details(product_attr.id)
    end
  end


end