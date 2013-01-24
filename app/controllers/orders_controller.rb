class OrdersController < ApplicationController

  before_filter :authorize_user, :except => [:add_line_item_to_order, :index]
  before_filter :user_logged_or_anonymous, :only => [:add_line_item_to_order, :index]
  before_filter(:only => [:confirm,:update,:pay, :cancel_order]) { @order = Order.find(params[:id]) }

  def index  
  end

  def add_line_item_to_order 
    @orders.add_line_item(params[:id],params[:price])    
    respond_to do |format|
      if @orders.save
        # [FIXME_CR] Message should be more appropriate e.g. "Product one" added successfully to you cart.
        flash[:notice] = 'Product successfully added to cart'
      else
        # [FIXME_CR] Message should be more appropriate.
        # Should let user know what wrong exacly going on. e.g "Product One" is out of stock etc.
        flash[:error] = 'invalid addition to order'
      end
      format.html { redirect_to request.referrer }
    end
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
end