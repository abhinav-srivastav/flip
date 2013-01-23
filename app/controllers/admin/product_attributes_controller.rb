class Admin::ProductAttributesController < Admin::BaseController
  before_filter(:only => [:destroy, :edit, :update]) { @attribute = ProductAttribute.find(params[:id])  }

  def index 
  	@attributes = ProductAttribute.all
  	respond_to do |format|
  	  format.html 
  	end
  end

  def new
  	@attribute = ProductAttribute.new
    @attribute.product_details.build(:product_id => params[:product_id]) if params[:product_id]
    @@return_path = request.referrer
  end

  def create 
    @attribute  = ProductAttribute.new(params[:product_attribute])
    respond_to do |format|
      if @attribute.save
        format.html {redirect_to @@return_path, flash: { success: 'New attribute '+@attribute.attribute+' created'} }
      else
        format.html {render action: 'new'}
      end
    end
  end

  def edit 
  end

  def update
    respond_to do |format|
      if @attribute.update_attributes(params[:product_attribute])
        format.html { redirect_to admin_product_attributes_path, flash: { success: 'Attribute '+@attribute.attribute+' updated !'} }
      else
        format.html { render action: "edit"}
      end
    end
  end

  def destroy
  	@attribute.destroy
  	respond_to do |format|
  	  format.html { redirect_to request.referrer, notice: 'Attribute deleted successfully.'}
  	end
  end
end