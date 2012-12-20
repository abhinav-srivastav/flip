class Address < ActiveRecord::Base
  belongs_to :user
  has_many :orders
  attr_accessible :name, :street_no, :area, :postal_code, :city, :country, :user_id
end
