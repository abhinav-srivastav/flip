class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :authorized_to_remove_comment?
  private 
  def authorized_to_remove_comment?(comment)
    return false unless user_signed_in?
    return true if comment.user.id == current_user.id || current_user.admin
    false
  end

  def authorize_user
    unless user_signed_in?
      flash[:error] = 'Please log in first'
      respond_to do |format|
       format.html { redirect_to new_user_session_path }
       format.js { }   
      end
    end
  end
end