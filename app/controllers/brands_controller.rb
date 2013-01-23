class BrandsController < ApplicationController
  before_filter(:only => [:show, :show_all]) { @cat = Category.find(params[:category_id]) }

	def show
    @brand  = Brand.find(params[:id]) 
    respond_to do |format|
      format.html
    end
  end
  def show_all
    respond_to do |format|
      format.html
    end
  end
end
