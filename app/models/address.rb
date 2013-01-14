class Address < ActiveRecord::Base
  belongs_to :user
  has_many :orders, :dependent => :nullify
  attr_accessible :name, :street_no, :area, :postal_code, :city, :state, :country, :user_id
  validates_presence_of :name, :street_no, :city, :state, :country
end
