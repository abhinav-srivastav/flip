class Admin::AttributesController < ApplicationController
  def index 
  	@attributes = Attribute.all
  	respond_to do |format|
  	  format.html 
  	end
  end

  def new
  	@attribute = Attribute.new
  end

  def create 
    @attribute  = Attribute.new(params[:attribute])
    respond_to do |format|
      if @attribute.save
        format.html {redirect_to admin_attributes_path}
      else
        format.html {render action: 'new'}
      end
    end
  end

  def edit 
  	@attribute = Attribute.find(params[:id]) 
  end

  def update
    @attribute = Attribute.find(params[:id])
    respond_to do |format|
      if @attribute.update_attributes(params[:attribute])
        format.html { redirect_to admin_attributes_path }
      else
        format.html { render action: "edit"}
      end
    end
  end

  def destroy
  	@attribute = Attribute.find(params[:id])
  	@attribute.destroy
  	respond_to do |format|
  	  format.html { redirect_to request.referrer, notice: 'Attribute deleted successfully.'}
  	end
  end

end
