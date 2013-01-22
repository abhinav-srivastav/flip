class ApplicationController < ActionController::Base
  protect_from_forgery

  # [FIXME_CR] We are doing skip_before_filter :admin_authorize for all public controller. To keep things simple and clean, please 
  # create a new Admin::BaseController and inherite all admin controllers from the newly created controller
  # 1. Move below mentioned before_filter to newly created controller (Admin::BaseController ).
  # 2. Rename application layout to admin layout and include this in newly created controller (Admin::BaseController ).
  # 3. Rename public layout to application and remove all "layout :public" from all public controllers.

  before_filter :admin_authorize

  # [FIXME_CR] We can also write this into a single line (helper_method :current_user, :admin_logged_in?, :logged_in?)
  helper_method :current_user
  helper_method :admin_logged_in?
  helper_method :logged_in?

  private
  
  # [FIXME_CR] Not sure what this method is doing exectly.
  # Actually not sure why we are crediting first super user (admin) all the time if found.
  # Also not sure why we are returning false in case of credit to a user.
  # If still needed then should be a part of User model with name something like credit_wallet because we are crediting user's wallet.
  # If 
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

  # [FIXME_CR] Here we are debiting user's account. So, this should be a part of User model
  # Again we are debiting first super user not sure why
  def debit_from_admin(amount)
    admin = User.super
    admin.wallet -= amount
    admin.save
  end

  # [FIXME_CR] We should use attribute with '?' if a boolean response is needed
  # So, instead of current_user.admin use current_user.admin? and !! is not needed
  def admin_logged_in?
  	logged_in? && !!(current_user.admin)
  end

  def logged_in?
    !!(current_user)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # [FIXME_CR] This will move to Admin::BaseController 
  # authorize_admin seems more appropriate.
  def admin_authorize
  	unless admin_logged_in?
  		redirect_to :root
  	end
  end
  
  # [FIXME_CR] authorize_user seems more appropriate.
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
