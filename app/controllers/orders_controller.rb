class OrdersController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
  before_filter :user_authorize

  def index 
  	@order = Order.current_user_open_order(current_user.id)
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
    @order.amount +=  (@line_item.price * @line_item.quantity)
    respond_to do |format|
      if @order.save
        flash[:notice] = 'Added to order'
      else
        flash[:error] = 'invalid addition to order'
      end
      format.html { redirect_to request.referrer}
    end
  end

  def pay
    
  end
end
