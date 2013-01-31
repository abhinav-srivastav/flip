class RatingsController < ApplicationController

  before_filter :authorize_user
  
  def new
    @rating = current_user.ratings.new(:product_id => params[:product_id])
  end
  
  def create
    @rating =  current_user.ratings.find_or_create(params[:rating])
    respond_to do |format|
      if @rating.save
        @product = @rating.product
        format.html {redirect_to product_path(@product) }
        format.js
      else
        format.html {render action: 'new'}
      end
    end
  end
end
