class OrdersController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
  before_filter :user_authorize

  def index 
  	@order = Order.current_user_open_order(current_user.id)
    if @order
      @order.amount = order_amount(@order.line_items)
      @order.save
    else
      flash.now[:error] = 'No Items in your trolley !'
    end
  	respond_to do |format|
  	  format.html
  	end
  end

  def create 
    @order = Order.current_user_open_order(current_user.id)
    @order = Order.create(:user_id => current_user.id) if @order.nil?
    @order = add_line_item(@order, params[:id],params[:price])
    respond_to do |format|
      if @order.save
        flash[:notice] = 'Added to order'
      else
        flash[:error] = 'invalid addition to order'
      end
      format.html { redirect_to request.referrer}
    end
  end

  def confirm
    @order = Order.find(params[:id])
  end

  def update 
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order]) 
      #flash[:success] = 'order details updated '
    #else
      #flash[:error] = 'error updating order'
    end  
    render :confirm    
  end

  def pay
    @order = Order.find(params[:id])
    respond_to do |format|
      if @order.pay
        flash[:success] = 'Payment made successfully!'
        format.html { redirect_to :root }
      else
        flash[:error] = 'Not enough balance in your wallet/address left blank!'
        format.html { redirect_to request.referrer }
      end
    end
  end

  def booked
    @orders = Order.user_orders(current_user.id)
    respond_to do |format|
      format.html
    end
  end

 private
  def add_line_item(order, product_id, product_price)
    line_item = order.line_items.find_by_product_id(product_id)
    if line_item.nil?
      order.line_items.new(:product_id => product_id, :price => product_price)
    else
      line_item.quantity += 1
      line_item.save
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
