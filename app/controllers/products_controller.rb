class ProductsController < ApplicationController

  def show		
    @product = Product.includes(:images, :ratings, :brand, {:reviews => :user}  ,:product_details => [:product_attribute]).find(params[:id]) 
    @varients = @product.varients.includes(:size,:colour).availables
    respond_to do |format|
      format.html
    end
  end
end
