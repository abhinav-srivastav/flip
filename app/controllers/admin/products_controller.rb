class Admin::ProductsController < ApplicationController
  def index
  	@products = Product.all
    respond_to do |format|
		  format.html
	  end
  end

  def new
    @product = Product.new
    @product.images.build
    @product.varients.build
  end

  def create 
    @product  = Product.new(params[:product])
    respond_to do |format|
      if @product.save
        format.html {redirect_to edit_admin_product_path(@product) }
      else
        @product.images.build
        @product.varients.build
        format.html {render action: 'new'}
      end
    end
  end

	def edit 
		@product = Product.find(params[:id])
    @other_attr = ProductAttribute.other_attributes(@product)
    @product.images.build
    @product.varients.build
    @product.product_attributes.build.product_details.build
	end
	
  def update
		@product = Product.find(params[:id])
		respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:success] = "Product updated !"
        format.html { redirect_to admin_products_path }
      else
        @other_attr = ProductAttribute.other_attributes(@product)
        @product.images.build
        @product.varients.build
        @product.product_attributes.build.product_details.build
        format.html { render action: "edit"}
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to request.referer }
    end
  end

end
