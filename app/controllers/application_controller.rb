class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_cart
  after_filter :store_location
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

  def current_cart
    if user_signed_in?
      order = current_user.cart
    else
      unless order = Order.where('id=?',session[:order_id]).first        
        order = Order.create() 
        session[:order_id] = order.id
      end
      order
    end
  end
  
  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/(admin|LogIn)/
  end

  def after_sign_in_path_for(resource)
    if order = Order.where('id=?',session[:order_id]).first
      current_user.merge_to_my_cart(order)
    end
    session[:order_id] = nil
    session[:previous_url] || root_path
  end
end