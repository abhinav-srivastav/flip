class Admin::ProductDetailsController < Admin::BaseController
  before_filter(:except => [:create]) { @pd = ProductDetail.find(params[:id])  }
  def destroy
    common_destroy(@pd, request.referrer, admin_product_details_path, {notice: 'Attribute details successfully removed'})
  end
  
  def create
    @pd  = ProductDetail.new(params[:product_detail])
    respond_to do |format|
      if @pd.save
        flash[:success] = 'Attribute added'
      else
        flash[:error] = 'Attribute already exist'
      end
      format.html { redirect_to edit_admin_product_path(@pd.product_id) }
    end
  end

  def edit
  end

  def update
  	respond_to do |format|
  	  if @pd.update_attributes(params[:product_detail])
  	  	format.html { redirect_to edit_admin_product_path(@pd.product), flash: { success: 'Attribute Updated !' } }
  	  else
  	  	format.html { render action: 'edit' } 
  	  end
  	end
  end
end