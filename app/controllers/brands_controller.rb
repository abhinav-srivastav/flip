class BrandsController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
	def show
    @brand  = Brand.find(params[:id]) 
    @cat = Category.find(params[:category_id])
    respond_to do |format|
      format.html
    end
  end
  def show_all
    @cat = Category.find(params[:category_id])
    respond_to do |format|
      format.html
    end
  end
end
