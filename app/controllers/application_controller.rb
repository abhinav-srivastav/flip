class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private 

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