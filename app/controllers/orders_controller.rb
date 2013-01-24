class OrdersController < ApplicationController

  before_filter :authorize_user
  before_filter(:only => [:confirm,:update,:pay, :cancel_order]) { @order = Order.find(params[:id]) }

  def open
  	@order = current_user.orders.open_state
    @order.save
  	respond_to do |format|
  	  format.html
  	end
  end

  def add_line_item_to_order 
    @order = current_user.orders.open_state
    @order.add_line_item(params[:id],params[:price])
    respond_to do |format|
      if @order.save
        # [FIXME_CR] Message should be more appropriate e.g. "Product one" added successfully to you cart.
        flash[:notice] = 'Added to order'
      else
        # [FIXME_CR] Message should be more appropriate.
        # Should let user know what wrong exacly going on. e.g "Product One" is out of stock etc.
        flash[:error] = 'invalid addition to order'
      end
      format.html { redirect_to request.referrer }
    end
  end

  def confirm
  end

  def update 
    if @order.update_attributes(params[:order])
      flash.now[:success] = 'order details updated '
    else
      # [FIXME_CR] Message should be more appropriate.
      # Should let user know what wrong exacly going on. e.g "Product One" is out of stock etc.
      flash.now[:error] = 'error updating order'
    end  
    render :action =>  'confirm' 
  end

  def pay
    respond_to do |format|
      if @order.pay
        Notifier.booking(@order.user.email, @order.user.username, @order).deliver
        format.html { redirect_to user_path(current_user), :flash => { :success => 'Payment made successfully!' } }
      else
        format.html { redirect_to request.referrer, :flash => { :error => 'Invalid details to place an order !' } }
      end
    end
  end

  # [FIXME_CR] This should be part of orders index action.
  # Orders listing should be handeled by by index action if possible.
  def booked
    @orders = current_user.orders.with_state('booked')
    respond_to do |format|
      format.html
    end
  end
  
  def cancel_order
    respond_to do |format|    
      if @order.cancel 
        Notifier.cancellation(@order.user.email, @order.user.username, @order).deliver  
        flash[:notice] = 'Order Cancelled.Credit refunded to wallet !'
      else
        flash[:error]  = 'Order can\'t be cancelled now'
      end
      format.html { redirect_to request.referrer }
    end
  end

  def cancel
    @orders = current_user.orders.with_state('cancel')
  end

  def dispatched
    @orders = current_user.orders.with_state('dispatched')
    respond_to do |format|
      format.html
    end
  end

  def deliver
    @orders = current_user.orders.with_state('delivered')
    respond_to do |format|
      format.html
    end
  end
end