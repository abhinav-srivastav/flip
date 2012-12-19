class OrdersController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
  before_filter :user_authorize

  def index 
  	@order = Order.current_user_open_order(current_user.id)
    @order.amount = order_amount(@order.line_items)
  	respond_to do |format|
  	  if @order.nil?
  	  	flash[:error] = 'No Items in your trolley !'
        format.html { redirect_to request.referrer  }
  	  end
  	  format.html
  	end
  end

  def create 
    @order = Order.current_user_open_order(current_user.id)
    @order = Order.create(:user_id => current_user.id) if @order.nil?
    @line_item = @order.line_items.new(:product_id => params[:id], :price => params[:price])
    @order.amount =  order_amount(@order.line_items)
    respond_to do |format|
      if @order.save
        flash[:notice] = 'Added to order'
      else
        flash[:error] = 'invalid addition to order'
      end
      format.html { redirect_to request.referrer}
    end
  end
  
  def edit
    @order = Order.find(params[:id])
  end








  def pay
    @order = Order.find(params[:id])
    respond_to do |format|
      if @order.pay
        flash[:success] = 'Payment made successfully!'
        format.html { redirect_to :root }
      else
        flash[:error] = 'Not enough balance in your wallet!'
        format.html { redirect_to request.referrer }
      end
    end
  end

 private

  def order_amount(line_items)
    amount = 0
    line_items.each do |item|
      amount += item.price * item.quantity
    end
    amount
  end
end
