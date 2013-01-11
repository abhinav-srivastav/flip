class Admin::ProductAttributesController < ApplicationController
  def index 
  	@attributes = ProductAttribute.all
  	respond_to do |format|
  	  format.html 
  	end
  end

  def new
  	@attribute = ProductAttribute.new
    @attribute.product_details.build
  end

  def create 
    @attribute  = ProductAttribute.new(params[:product_attribute])
    respond_to do |format|
      if @attribute.save
        format.html {redirect_to admin_product_attributes_path }
      else
        format.html {render action: 'new'}
      end
    end
  end

  def edit 
  	@attribute = ProductAttribute.find(params[:id]) 
  end

  def update
    @attribute = ProductAttribute.find(params[:id])
    respond_to do |format|
      if @attribute.update_attributes(params[:product_attribute])
        format.html { redirect_to admin_product_attributes_path }
      else
        format.html { render action: "edit"}
      end
    end
  end

  def destroy
  	@attribute = ProductAttribute.find(params[:id])
  	@attribute.destroy
  	respond_to do |format|
  	  format.html { redirect_to request.referrer, notice: 'Attribute deleted successfully.'}
  	end
  end

end
