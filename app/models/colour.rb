class Colour < ActiveRecord::Base
  has_many :varients
  attr_accessible :colour
end