class Admin::ProductsController < Admin::BaseController
  before_filter(:only => [:destroy, :update]) { @product = Product.find(params[:id])  }
  def index
  	@products = Product.all
    respond_to do |format|
		  format.html
	  end
  end

  def new
    @product = Product.new
    @product.images.build
  end

  def create 
    @product  = Product.new(params[:product])
    respond_to do |format|
      if @product.save
        format.html {redirect_to edit_admin_product_path(@product), flash: { success: 'New product '+@product.product+' created'} }
      else
        @product.images.build
        format.html {render action: 'new'}
      end
    end
  end

	def edit 
    @product = Product.includes({:product_details => :product_attribute}, :images, {:varients => [:size, :colour]}, :prototypes).find(params[:id])
    @root_category = Category.root
    @other_attr = ProductAttribute.other_attributes(@product)
    @product.images.build
    @product.product_attributes.build.product_details.build
	end
	
  def update
		respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to admin_products_path, flash: { success: 'Product '+@product.product+' updated !'} }
      else
        @other_attr = ProductAttribute.other_attributes(@product)
        @product.images.build
        @product.product_attributes.build.product_details.build
        format.html { render action: "edit"}
      end
    end
  end

  def destroy
    common_destroy(@product, request.referrer, admin_products_path, {notice: 'selected product deleted'})
  end
end