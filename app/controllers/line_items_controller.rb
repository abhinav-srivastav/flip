class LineItemsController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
  before_filter :user_authorize

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.order.amount -= (@line_item.price * @line_item.quantity)
    @line_item.order.save
    @line_item.destroy 
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Removed line item !' }
    end
    
  end

end
