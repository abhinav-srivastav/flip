class Admin::ProductDetailsController < ApplicationController
  def destroy
  	@pd = ProductDetail.find(params[:id])
  	@pd.destroy
  	respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Attribute successfully removed' }
  	end
  end

  def edit
    @pd = ProductDetail.find(params[:id])
  end

  def update
  	@pd = ProductDetail.find(params[:id])
  	respond_to do |format|
  	  if @pd.update_attributes(params[:product_detail])
  	  	format.html { redirect_to admin_products_path }
  	  else
  	  	format.html { render action: 'edit' } 
  	  end
  	end
  end

end
