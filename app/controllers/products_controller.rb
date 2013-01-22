class ProductsController < ApplicationController

  def show		
    @product = Product.find(params[:id]) 
    @varients = @product.varients.availables
    respond_to do |format|
      format.html
    end
  end
end
