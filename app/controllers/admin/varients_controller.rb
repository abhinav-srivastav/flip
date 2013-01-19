class Admin::VarientsController < ApplicationController
  def edit
    @varient = Varient.find(params[:id])
  end

  def update
    @varient = Varient.find(params[:id])
    respond_to do |format|
      if @varient.update_attributes(params[:varient])
      	format.html { redirect_to edit_admin_product_path(@varient.product),:success => 'varient updated' } 
      else
      	format.html { render action: 'edit' }
      end
    end
  end
end
