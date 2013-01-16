class RatingsController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
  before_filter :user_authorize
  
  def new
    @rating = Rating.new
    @@product_id = params[:product_id]
  end

  def create
    @rating =  Rating.user_rating(current_user.id, @@product_id)
    rate = params[:rating]
    @rating.rating = rate['rating'] 
    @rating.product_id = @@product_id 
    respond_to do |format|
      if @rating.save
        flash[:success] = 'Your ratings have been recorded'
      else
      	flash[:error] = 'Error recoring ratings'
      end  
      format.html { redirect_to product_path(@rating.product_id) }
    end
  end

end
