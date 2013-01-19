class Size < ActiveRecord::Base
  has_many :varients
  attr_accessible :size
end