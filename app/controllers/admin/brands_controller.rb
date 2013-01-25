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
    @brand  = Brand.new(params[:brand])
    respond_to do |format|
      if @brand.save
        format.html {redirect_to admin_brands_path, flash: { success: 'New brand named '+@brand.brand+' created.'}}
      else
        format.html {render action: 'new'}
      end
    end
  end

	def edit 
	end
	
  def update
    common_update(@brand, admin_brands_path, 'brand')
	end

	def destroy
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, flash: { notice: 'Selected brand destroyed'  } }
    end
  end    
end