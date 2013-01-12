class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :admin_authorize

  helper_method :current_user
  helper_method :admin_logged_in?
  helper_method :logged_in?
  private

  def admin_logged_in?
  	logged_in? && !!(current_user.admin)
  end

  def logged_in?
    !!(current_user)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin_authorize
  	unless admin_logged_in?
  		redirect_to :root
  	end
  end
  
  def user_authorize
    unless logged_in?
      flash[:error] = 'Please log in first'
      redirect_to login_path
    end
  end

end
