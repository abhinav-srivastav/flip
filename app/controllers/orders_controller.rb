class OrdersController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
  before_filter :user_authorize

  def index 
  	@orders = Order.find_all_by_user_id(current_user.id)
  	respond_to do |format|
  	  if @orders.empty?
  	  	flash[:error] = 'No Items in your trolley !'
        format.html { redirect_to request.referrer  }
  	  end
  	  format.html
  	end
  end


  def create 
    @order = Order.find_or_create_by_user_id(current_user.id)
    @order.line_items.new(:product_id => params[:id], :price => params[:price])
    @order.amount +=  params[:price].to_i

    respond_to do |format|
      if @order.save
        flash[:notice] = 'Added to order'
      else
        flash[:error] = 'invalid addition to order'
      end
      format.html { redirect_to request.referrer}
    end
  end
end
