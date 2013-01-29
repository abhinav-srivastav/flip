class Admin::ImagesController < Admin::BaseController

  def destroy
  	@image = Image.find(params[:id])
  	@image.destroy
  	respond_to do |format|  	
      format.html { redirect_back_or_other_path(request.referrer, admin_products_path,{ notice: 'Image removed !'}) }
  	end
  end
end
