class Admin::OrdersController < Admin::BaseController
  before_filter(:only => [:show, :destroy]) { @order = Order.find(params[:id]) }
  def index 
    @orders = Order.order('updated_at desc')
    respond_to do |format|
      format.html 
    end
  end

  def show
  end

	def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Deleted successfully'}
    end
  end
end
