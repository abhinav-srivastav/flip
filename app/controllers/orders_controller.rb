class OrdersController < ApplicationController

  before_filter :authorize_user, :except => [:add_line_item_to_order, :index]
  before_filter :user_logged_or_anonymous, :only => [:add_line_item_to_order, :index]
  before_filter(:only => [:confirm,:update,:pay, :cancel_order]) { @order = Order.find(params[:id]) }
  before_filter :cart_has_line_items, :only => :confirm

  # We should define a before filter in the same controller instead of defining it in ApplicationController if needed
  # Also should find and render orders for the allowed states only. 
  def index  
  end

  # [FIXME_CR] _to_order is not needed in this action name.
  # We have aready discussed the reason of this
  def add_line_item_to_order 
    # [FIXME_CR] @orders should be @order. Because @orders return singular
    @orders.add_line_item(params[:id],params[:price])    
    respond_to do |format|
      if @orders.save
        flash[:notice] = params[:product]+' successfully added to cart'
      end
      # [FIXME_CR] We should handle if there is no referrer.
      # We can define a method back_of_default(path, options) and check if referrer exists or not and take action accordingly.
      format.html { redirect_to request.referrer }
    end
  end

  def update
    # [FIXME_CR] Here we should check if order update is successfull or not
    # And action should be taken accordingly
    @order.update_attributes(params[:order])  
    respond_to do |format|
      # [FIXME_CR] We should handle if there is no referrer.
      format.html { redirect_to request.referrer }
    end
  end

  def confirm
  end

  def pay
    # [FIXME_CR] Here we are assigning params[:address] to order. Please lets make sure address passed in params[:address] exists
    #
    @order.address_id = params[:address]
    respond_to do |format|
      if @order.pay
        format.html { redirect_to user_path(current_user), :flash => { :success => 'Payment made successfully!' } }
      else
        if @order.address
          flash[:error] = 'Not enough credit in your wallet for this order'
        else
          flash[:error] = 'Please select/add an address !'
        end
          # [FIXME_CR] We should handle if there is no referrer.
          format.html { redirect_to request.referrer  }
      end
    end
  end
  
  # [FIXME_CR] No need to include _order. We have already discussed this
  def cancel_order
    respond_to do |format|    
      if @order.cancel 
        flash[:notice] = 'Order Cancelled.Credit refunded to wallet !'
      else
        flash[:error]  = 'Order can\'t be cancelled now'
      end
      # [FIXME_CR] We should handle if there is no referrer.
      format.html { redirect_to request.referrer }
    end
  end
  
  private
    def cart_has_line_items
      if @order.line_items.empty?
        redirect_to request.referrer, :flash => { error: 'Order should have atleast 1 product !' }
      end
    end
end