class Rating < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  attr_accessible :rating, :user_id, :product_id

  validates :rating, :presence => true
  scope :user_ratings, lambda { |u_id, p_id| where('user_id = ? and product_id = ? ', u_id, p_id) }

  def self.user_rating(u_id, p_id)
    rating = user_ratings(u_id, p_id).first
    if rating
      rating
    else
      create(:user_id => u_id, :product_id => p_id)
    end
  end
end
