class Comment < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  attr_accessible :comment, :product_id, :user_id
  validates_presence_of :comment, :product_id, :user_id

  before_destroy :user_authenticated_to_destroy?

  private
    def user_authenticated_to_destroy?
      return true if current_user.admin
      return true if self.user_id == current_user.id
      false
    end
end