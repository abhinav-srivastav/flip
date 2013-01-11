class Rating < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  attr_accessible :rating
end
