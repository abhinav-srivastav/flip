class LineItemsController < ApplicationController

  before_filter(:only => [:destroy, :edit, :update]) { @line_item = LineItem.find(params[:id]) }
  def destroy
    @line_item.destroy 
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Removed line item !' }
    end
  end
  
  def edit 
  end

  def update
    unless @line_item.update_attributes(params[:line_item]) 
      flash[:error] = 'Quantity asked for product '+@line_item.varient.product.product+' is not available'
    end
    respond_to do |format|
       format.html { redirect_to cart_orders_path }
    end
  end
end