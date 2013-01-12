class CategoriesController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
  def show
    @category =  Category.find(params[:id])
    @product = Product.order(:updated_at)
    respond_to do |format|
      format.html      
    end
  end
end
