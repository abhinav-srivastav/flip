class Admin::ImagesController < Admin::BaseController

  def destroy
  	@image = Image.find(params[:id])
  	common_destroy(@image, request.referrer, admin_products_path, {notice: 'image removed'})
  end
end
