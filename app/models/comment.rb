class Comment < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  attr_accessible :comment, :product_id, :user_id
  validates_presence_of :comment, :product_id, :user_id

  before_destroy :user_authorized_to_destroy?

  private
    def user_authorized_to_destroy?
    end
end