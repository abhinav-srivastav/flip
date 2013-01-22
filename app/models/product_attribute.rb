class ProductAttribute < ActiveRecord::Base
  has_many :product_details, :dependent => :destroy, :autosave => true
  has_many :products, :through => :product_details  	
  has_and_belongs_to_many :prototypes
  attr_accessible :product_attributes, :product_details_attributes
  accepts_nested_attributes_for :product_details

  validates :product_attributes, :uniqueness => true, :presence => true

  
  def self.other_attributes(product)
  	other_attr = []
  	all.each do |pa|
      unless pa.products.include?(product)
        other_attr << pa
      end
  	end
    other_attr
  end
end