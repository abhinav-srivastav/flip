class Comment < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  attr_accessible :comment
end
