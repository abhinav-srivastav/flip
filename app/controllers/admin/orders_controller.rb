class Admin::OrdersController < Admin::BaseController
  before_filter(:only => [:destroy]) { @order = Order.find(params[:id]) }
  def index 
    @orders = Order.order('updated_at desc')
    respond_to do |format|
      format.html 
    end
  end

  def show
    @order = Order.includes(:user, :address,:line_items => [:varient => [:product, :colour, :size]]).find(params[:id])
  end

	def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Deleted successfully'}
    end
  end
end
