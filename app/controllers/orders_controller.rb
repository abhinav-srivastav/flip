class OrdersController < ApplicationController

  before_filter :authorize_user
  def index 
  	@order = Order.current_user_open_order(current_user.id)
    @order.amount = order_amount(@order.line_items)
    @order.save
  	respond_to do |format|
  	  format.html
  	end
  end

  def create 
    @order = Order.current_user_open_order(current_user.id)
    @order = add_line_item(@order, params[:id],params[:price])
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
    @order = Order.find(params[:id])
  end

  def update 
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order]) 
      flash.now[:success] = 'order details updated '
    else
      flash.now[:error] = 'error updating order'
    end  
    render :action =>  'confirm' 
  end

  def pay
    @order = Order.find(params[:id])
    respond_to do |format|
      if @order.pay & credit_to_admin(@order.amount, @order.user)        
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
    @orders = Order.user_orders(current_user.id,'booked')
    respond_to do |format|
      format.html
    end
  end

  def cancel
    if request.post?
      @order = Order.find(params[:id])
      @order.user.wallet += @order.amount
      respond_to do |format|    
        if debit_from_admin(@order.amount) & @order.cancel 
          Notifier.cancellation(@order.user.email, @order.user.username, @order).deliver  
          flash[:notice] = 'Order Cancelled.Credit refunded to wallet !'
        else
          flash[:error]  = 'Order can\'t be cancelled '
        end
        format.html { redirect_to request.referrer }
      end
    else
      @orders = Order.user_orders(current_user.id,'cancel')
    end
  end

  def shipped
    @orders = Order.user_orders(current_user.id,'shipped')
    respond_to do |format|
      format.html
    end
  end

 private
  def add_line_item(order, varient_id, varient_price)
    line_item = order.line_items.find_by_varient_id(varient_id)
    if line_item.nil?
      line_item = order.line_items.new(:varient_id => varient_id, :price => varient_price)
    end
    order.amount = order_amount(order.line_items)
    order
  end

  def order_amount(line_items)
    amount = 0
    line_items.each do |item|
      amount += item.price * item.quantity
      amount += 30
    end
    amount
  end
end