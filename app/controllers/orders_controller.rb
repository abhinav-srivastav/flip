class OrdersController < ApplicationController

  before_filter :authorize_user, :except => [:add_line_item_to_order, :index]
  before_filter :user_logged_or_anonymous, :only => [:add_line_item_to_order, :index]
  before_filter(:only => [:confirm,:update,:pay, :cancel_order]) { @order = Order.find(params[:id]) }
  before_filter :cart_has_line_items, :only => :confirm
  def index  
  end

  def add_line_item_to_order 
    @orders.add_line_item(params[:id],params[:price])    
    respond_to do |format|
      if @orders.save
        flash[:notice] = params[:product]+' successfully added to cart'
      end
      format.html { redirect_to request.referrer }
    end
  end

  def update 
    @order.update_attributes(params[:order])  
    respond_to do |format|
      format.html { redirect_to request.referrer }
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
          format.html { redirect_to request.referrer  }
      end
    end
  end
  
  def cancel_order
    respond_to do |format|    
      if @order.cancel 
        flash[:notice] = 'Order Cancelled.Credit refunded to wallet !'
      else
        flash[:error]  = 'Order can\'t be cancelled now'
      end
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