class Admin::BrandsController < Admin::BaseController
  before_filter(:only => [:destroy, :edit, :update]) { @brand = Brand.find(params[:id]) }

  def index
  	@brands = Brand.all
    respond_to do |format|
		  format.html
	  end
  end
  def new
    @brand = Brand.new
  end

  def create 
    common_create(admin_brands_path, 'brand')
  end

	def edit 
	end
	
  def update
    common_update(@brand, admin_brands_path, 'brand')
	end

	def destroy
    common_destroy(@brand, request.referrer, admin_brands_path, {notice: 'Selected brand deleted'})
  end   
end