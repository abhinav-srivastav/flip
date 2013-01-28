class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :authorized_to_remove_comment?

  private 

  # [FIXME_CR] I have found this method is only used in views. Are we going to use this anywhere in controller?
  # If a method is required only as a helper method then that should be declared in corresponding helper only. No need to define in controller.
  #
  def authorized_to_remove_comment?(comment)
    return false unless user_signed_in?

    # [FIXME_CR] current_user should let us know if he can delete comment.
    # So, lets move this to user model something like this.
    # current_user.has_access_to?(record, options)
    # def has_access_to?(record, options={})
    #   return true if self.admin?
    #   options = { :readonly => false }.merge(options)
    #   case record && record.class.class_name
    #   when 'Comment'
    #     conditions
    #   end
    # end
    # 
    # Let me know your thoughts on this.
    return true if comment.user.id == current_user.id || current_user.admin
    false
  end

  # [FIXME_CR] Please handle if user is not user_signed_in? conditions
  # we should return false in that case. 
  def authorize_user
    unless user_signed_in?
      flash[:error] = 'Please log in first'
      respond_to do |format|
       format.html { redirect_to new_user_session_path }
       format.js { }   
      end
    end
  end

  # [FIXME_CR] It seems here we are initializing or finding a cart (new Order with cart state)
  # If yes please rename this to something like initialize_or_create_cart
  # Or even this can be used to return current_cart. So we can call this current_cart
  # 
  def user_logged_or_anonymous
    if user_signed_in?
      # [FIXME_CR] We are assigning single order to @orders. So it should be singular (e.g. @order)
      # Even if no need to defind instance variable here. define it where we need this. e.g  = @order = current_cart
      # We also forgot one condition here. if there is no order with the given state then new order should be created
      # current_cart should return a order either existing or new one.
      # We should not pass params[:state] directly to order_with_state. Here user can get order with different state (params[:state]=dispatched or delivered etc.)
      # So, we should do somthing like (allowed_states).include?(params[:state]).
      @orders = current_user.order_with_state(params[:state])
    else
      # [FIXME_CR] as we are storing order_id in session. So , lets call this session[:order_id]
      if session[:order]
        # [FIXME_CR] find order from current_user's incomplete order only(e.g. state cart). eg current_user.orders.find(session[:order])
        @orders = Order.find(session[:order])
      else
        @orders = Order.create() 
        session[:order] = @orders.id
      end
    end
  end
  
  def after_sign_in_path_for(user)
    if session[:order]
      # [FIXME_CR] Here it might be possible that there is no order with session[:order] or even session[:order] itself is nil
      # Then this with through an exception. 
      order = Order.find(session[:order])

      # [FIXME_CR] Lets discuss add_to_cart method
      current_user.add_to_cart(order)

      # [FIXME_CR] Not sure why we are resetting session[:order]
      session[:order] = nil
    end
    root_path
  end
end