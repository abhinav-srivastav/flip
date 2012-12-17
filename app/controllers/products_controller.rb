class ProductsController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
	def show
    @product  = Product.find(params[:id]) 
    respond_to do |format|
      format.html
    end
  end
end
