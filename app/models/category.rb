class Category < ActiveRecord::Base
  has_many :brands
   attr_accessible :category
   scope :visible, where(:visible => true)


  def products
  	c = []
    self.brands.each { |brand| c << brand.products }
    c.flatten!
  end
end
