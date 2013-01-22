class LineItemsController < ApplicationController

  before_filter :authorize_user
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
    if (params[:line_item][:quantity].to_i > @line_item.varient.available) 
      flash[:error] = 'Quantity asked for product '+@line_item.varient.product.product+' is not available'
    else
      unless @line_item.update_attributes(params[:line_item]) 
        flash[:error] = 'Invalid quantity'
      end
    end
    respond_to do |format|
       format.html { redirect_to orders_path }
    end
  end
end