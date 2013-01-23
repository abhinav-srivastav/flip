class Admin::BaseController < ActionController::Base
 layout 'admin'
 protect_from_forgery

 before_filter :authorize_admin
 helper_method :admin_logged_in?, :current_user, :logged_in?

 private

  def authorize_admin
  	unless admin_logged_in?
  		redirect_to :root
  	end
  end

  def admin_logged_in?
  	logged_in? && current_user.admin
  end

  def logged_in?
    !!(current_user)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end