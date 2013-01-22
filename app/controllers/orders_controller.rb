class OrdersController < ApplicationController

  before_filter :authorize_user
  before_filter(:only => [:confirm,:update,:pay]) { @order = Order.find(params[:id]) }
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
        flash[:notice] = 'Added to order'
      else
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
      flash.now[:error] = 'error updating order'
    end  
    render :action =>  'confirm' 
  end

  def pay
    respond_to do |format|
      if @order.pay
        Notifier.booking(@order.user.email, @order.user.username, @order).deliver
        flash[:success] = 'Payment made successfully!'
        format.html { redirect_to user_path(current_user) }
      else
        flash[:error] = 'Invalid details to place an order !'
        format.html { redirect_to request.referrer }
      end
    end
  end

  def booked
    @orders = current_user.orders.with_state('booked')
    respond_to do |format|
      format.html
    end
  end
  def cancel
    if request.post?
      @order = Order.find(params[:id])
      respond_to do |format|    
        if @order.cancel 
          Notifier.cancellation(@order.user.email, @order.user.username, @order).deliver  
          flash[:notice] = 'Order Cancelled.Credit refunded to wallet !'
        else
          flash[:error]  = 'Order can\'t be cancelled '
        end
        format.html { redirect_to request.referrer }
      end
    else
      @orders = current_user.orders.with_state('cancel')
    end
  end
  def dispatched
    @orders = current_user.orders.with_state('dispatched')
    respond_to do |format|
      format.html
    end
  end
end