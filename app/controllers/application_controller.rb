class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?

  private 
  def logged_in?
    !!(current_user)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize_user
    unless logged_in?
      flash[:error] = 'Please log in first'
      respond_to do |format|
       format.html { redirect_to login_path }
       format.js { }   
      end
    end
  end
end