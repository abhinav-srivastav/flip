class CategoriesController < ApplicationController

  def show
    @category =  Category.includes(:products => [:images, :brand, :varients]).find(params[:id])
    respond_to do |format|
      format.html      
    end
  end
end
