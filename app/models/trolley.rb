class Trolley < ActiveRecord::Base
  has_and_belongs_to_many :products
 
  # attr_accessible :title, :body
end
