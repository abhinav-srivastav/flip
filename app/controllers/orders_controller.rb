class OrdersController < ApplicationController

  before_filter :authorize_user, :except => [:add_line_item, :cart]
  before_filter(:only => [:confirm,:update,:pay, :cancelled]) { @order = Order.find(params[:id]) }
  before_filter :cart_has_line_items, :only => :confirm

  def index  
    @orders = current_user.order_with_state(params[:state])
  end
  
  def cart
    @order = current_cart
  end

  def add_line_item 
    @order = current_cart
    @order.add_line_item(params[:id],params[:price])    
    respond_to do |format|
      if @order.save
        flash[:notice] = params[:product]+' successfully added to cart'
      end
      format.html { redirect_back_or_other_path(request.referrer,cart_orders_path) }
    end
  end

  def confirm
  end

  def pay
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
        format.html { redirect_to confirm_order_path(@order)  }
      end
    end
  end
  
  def cancelled
    respond_to do |format|    
      if @order.cancel 
        flash[:notice] = 'Order Cancelled.Credit refunded to wallet !'
      else
        flash[:error]  = 'Order can\'t be cancelled now'
      end
      format.html { redirect_back_or_other_path(request.referrer, orders_path) }
    end
  end
  
  private
    def cart_has_line_items
      if @order.line_items.empty?
        redirect_to request.referrer, :flash => { error: 'Order should have atleast 1 product !' }
      end
    end
end