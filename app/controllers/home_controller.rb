class HomeController < ApplicationController

  def index 
  	@categories = Category.includes(:products => [:brand, :varients, :images]).visible
  	@product = Product.includes(:varients, :images).order('created_at desc').limit(5)
  	respond_to do |format|
      format.html  # index.html.erb
    end
  end
  
end
