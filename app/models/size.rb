class Size < ActiveRecord::Base
  has_many :varients
  attr_accessible :size
  validates :size, :presence => true, :uniqueness => true
end