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

  def user_logged_or_anonymous
    if user_signed_in?
      @orders = current_user.order_with_state(params[:state])
    else
      if session[:order]
        @orders = Order.find(session[:order])
      else
        @orders = Order.create() 
        session[:order] = @orders.id
      end
    end
  end
  
  def after_sign_in_path_for(user)
    if session[:order]
      order = Order.find(session[:order])
      current_user.add_to_cart(order)
      session[:order] = nil
    end
    root_path
  end
end