class Admin::ProductDetailsController < ApplicationController
  def destroy
  	@pd = ProductDetail.find(params[:id])
  	@pd.destroy
  	respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Attribute successfully removed' }
  	end
  end

end
