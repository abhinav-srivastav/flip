class Rating < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  attr_accessible :rating, :user_id, :product_id

  scope :user_ratings, lambda { |u_id| where('user_id = ? ', u_id)   }

  def self.user_rating(id)
    rating = user_ratings(id).first
    if rating
      rating
    else
      create(:user_id => id)
    end
  end
end
