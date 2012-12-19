class Admin::OrdersController < ApplicationController
  def index 
    @orders = Order.all
    respond_to do |format|
      format.html 
    end
  end

  def show
    @order = Order.find(params[:id])
  end

	def destroy
    @order = Order.find(params[:id])
    @order.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Deleted successfully'}
    end
  end
end
