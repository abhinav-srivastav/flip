class Admin::VarientsController < ApplicationController
  def new
    @varient = Varient.new
    @@product_id = params[:product_id]
  end

  def create
    @varient = Varient.new(params[:varient])
    @varient.product_id = @@product_id
    respond_to do |format|
      if @varient.save
        flash[:success] = 'varient added'
        format.html { redirect_to edit_admin_product_path(@varient.product) }
      else
        format.html {  render action: 'new' }
      end
    end
  end

  def edit
    @varient = Varient.find(params[:id])
  end

  def update
    @varient = Varient.find(params[:id])
    respond_to do |format|
      if @varient.update_attributes(params[:varient])
      	flash[:success] = 'varient updated'
      	format.html { redirect_to edit_admin_product_path(@varient.product) } 
      else
      	format.html { render action: 'edit' }
      end
    end
  end
  def destroy
    @varient = Varient.find(params[:id])
    @varient.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, :notice => 'varient deleted' } 
    end
    
  end
end
