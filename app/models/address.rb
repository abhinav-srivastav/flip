class Address < ActiveRecord::Base
  belongs_to :user
  has_many :orders
  attr_accessible :street_no, :area, :postal_code, :country
end
