class RatingsController < ApplicationController

  before_filter :authorize_user
  
  def new
    @rating = Rating.new
    @@product_id = params[:product_id]
  end

  def create
    @rating =  current_user.ratings.find_or_create(@@product_id, params[:rating][:rating])
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
