class HomeController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize

  def index 
  	@categories = Category.visible
  	@product = Product.order('created_at desc ')
  	respond_to do |format|
      format.html  # index.html.erb
    end
  end
  
end
