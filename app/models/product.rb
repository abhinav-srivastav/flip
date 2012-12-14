class Product < ActiveRecord::Base
  belongs_to :brand 
  attr_accessible :product
end
