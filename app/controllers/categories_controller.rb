class CategoriesController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
  def show
    @category =  Category.find(params[:id])
    respond_to do |format|
      format.html      
    end
  end
end
