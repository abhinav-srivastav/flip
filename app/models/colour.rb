class Colour < ActiveRecord::Base
  has_many :varients
  attr_accessible :colour
  validates :colour, :presence => true, :uniqueness => true
end