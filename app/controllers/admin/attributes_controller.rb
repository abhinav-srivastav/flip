class Admin::AttributesController < ApplicationController
  def index 
  	@attributes = Attributes.all
  	respond_to do |format|
  	  format.html 
  	end
  end


end
