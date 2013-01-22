class HomeController < ApplicationController

  def index 
  	@categories = Category.visible
  	@product = Product.order('created_at desc').limit(5)
  	respond_to do |format|
      format.html  # index.html.erb
    end
  end
  
end
