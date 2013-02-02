class VarientsController < ApplicationController
  
  def colours_for_size
  	@colour = Product.find(params[:size][:product_id]).varients.to_a.select{ |var| params[:size][:size].to_i == var[:size_id] }
    respond_to do |format|
      format.html {redirect_to product_path(params[:size][:product_id]) }
      format.js   
    end    
  end

  def sizes_for_colour
  	@size = Product.find(params[:colour][:product_id]).varients.to_a.select{ |var| params[:colour][:colour].to_i == var[:colour_id] }
    respond_to do |format|
      format.html {redirect_to product_path(params[:colour][:product_id]) }
      format.js   
    end    
  end
end