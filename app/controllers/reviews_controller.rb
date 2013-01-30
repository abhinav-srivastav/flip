class ReviewsController < ApplicationController

  before_filter :authorize_user

  def new
    @review = Review.new(:product_id => params[:product_id])
  end

  def create 
    @review = current_user.reviews.new(params[:review])
    respond_to do |format|
      if @review.save
        format.html {redirect_to product_path(@review.product_id) }
      else
        format.html {render action: 'new'}
      end
    end
  end

  def destroy  
    @review = Review.where('id=?',params[:id]).first
    respond_to do |format|
      if @review.destroy
        flash[:notice] = 'Review removed'
      else
        flash[:error] = 'Not allowed to remove this review'
      end
      format.html { redirect_back_or_other_path(request.referrer, root_path) } 
    end
  end
end