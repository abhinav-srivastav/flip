class Admin::BrandsController < ApplicationController
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
        format.html {redirect_to admin_brands_path}
      else
        format.html {render action: 'new'}
      end
    end
  end

	def edit 
		@brand = Brand.find(params[:id])
	end
	
  def update
		@brand = Brand.find(params[:id])
		respond_to do |format|
      if @brand.update_attributes(params[:brand])
        format.html { redirect_to admin_brands_path }
      else
        format.html { render action: "edit"}
      end
    end
	end

	def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to request.referer }
    end
  end

end
