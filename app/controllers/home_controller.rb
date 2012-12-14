class HomeController < ApplicationController
  def index 
  	@categories = Category.visible
  	respond_to do |format|
      format.html  # index.html.erb
    end
  end


end
