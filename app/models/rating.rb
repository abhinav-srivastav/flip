class Rating < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  attr_accessible :rating, :user_id, :product_id

  validates :rating, :presence => true
  scope :user_ratings, lambda { |u_id, p_id| where('user_id = ? and product_id = ? ', u_id, p_id) }

  def self.find_or_create(product_id, rating)
    product_rate = find_by_product_id(product_id)
    unless product_rate
      product_rate = new(:product_id => product_id)
    end
    product_rate.rating = rating
    product_rate
  end
end
