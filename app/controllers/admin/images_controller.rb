class Admin::ImagesController < Admin::BaseController

  def destroy
  	@image = Image.find(params[:id])
  	@image.destroy
  	respond_to do |format|  	
      format.html { redirect_to request.referrer, notice: 'Image removed !'  }
  	end
  end
end
