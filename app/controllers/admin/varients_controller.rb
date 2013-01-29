class Admin::VarientsController < Admin::BaseController
  before_filter(:only => [:destroy, :edit, :update]) { @varient = Varient.find(params[:id]) }
  def new
    @varient = Varient.new(:product_id => params[:product_id])
  end

  def create
    @varient = Varient.new(params[:varient])
    respond_to do |format|
      if @varient.save
        format.html { redirect_to edit_admin_product_path(@varient.product), flash: { success: 'New varient for '+@varient.product.product+' created'} }
      else
        format.html {  render action: 'new' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @varient.update_attributes(params[:varient])
      	format.html { redirect_to edit_admin_product_path(@varient.product), flash: { success: 'Varient updated'} } 
      else
      	format.html { render action: 'edit' }
      end
    end
  end
  def destroy
    @varient.destroy
    respond_to do |format|
      format.html { redirect_back_or_other_path(request.referrer, admin_products_path,{notice: 'Selected varient deleted'}) } 
    end
  end
end