class OrdersController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
  before_filter :user_authorize

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
        Notifier.booking(current_user.email, current_user.username ).deliver
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
          Notifier.cancellation(current_user.email, current_user.username).deliver  
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

 private
  def add_line_item(order, product_id, product_price)
    line_item = order.line_items.find_by_product_id(product_id)
    if line_item.nil?
      line_item = order.line_items.new(:product_id => product_id, :price => product_price)
    end
    order.amount = order_amount(order.line_items)
    order    
  end

  def order_amount(line_items)
    amount = 0
    line_items.each do |item|
      amount += item.price * item.quantity
    end
    amount
  end
end