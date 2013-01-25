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
		# respond_to do |format|
  #     if @brand.update_attributes(params[:brand])
  #       format.html { redirect_to admin_brands_path, flash: { success: 'Brand '+@brand.brand+' updated !'  } }
  #     else
  #       format.html { render action: "edit"}
  #     end
  #   end
	end

	def destroy
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, flash: { notice: 'Selected brand destroyed'  } }
    end
  end
  private
    def common_update(instance, return_path, field)
      respond_to do |format|
        if instance.update_attributes(params[field.to_sym])
          format.html { redirect_to return_path, flash: { success: field.capitalize+' '+instance[field]+' updated !'  } }
        else
          format.html { render action: "edit"}
        end
      end
    end
end