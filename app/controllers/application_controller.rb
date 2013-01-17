class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :admin_authorize

  helper_method :current_user
  helper_method :admin_logged_in?
  helper_method :logged_in?
  private
  
  def credit_to_admin(amount, buyer)
    admin = User.super
    admin.wallet += amount
    if admin.save
      return true 
    else
      buyer.wallet += amount
      buyer.save
      return false
    end     
  end

  def debit_from_admin(amount)
    admin = User.super
    admin.wallet -= amount
    admin.save
  end

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
      respond_to do |format|
       format.html { redirect_to login_path }
       format.js {  }   
      end
    end
  end

end
