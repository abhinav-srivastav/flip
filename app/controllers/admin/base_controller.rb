class Admin::BaseController < ApplicationController
 layout 'admin'

 before_filter :authorize_admin
 helper_method :admin_logged_in?

 private

  def authorize_admin
  	unless admin_logged_in?
  		redirect_to :root
  	end
  end

  def admin_logged_in?
  	user_signed_in? && current_user.admin
  end
end