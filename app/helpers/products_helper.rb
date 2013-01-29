module ProductsHelper
  def user_authorized_to_delete?(comment)
  	return false unless user_signed_in?
    return true if current_user.admin || comment.user_id == current_user.id
    false
  end
end