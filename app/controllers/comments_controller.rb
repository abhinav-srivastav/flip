class CommentsController < ApplicationController

  before_filter :authorize_user

  def new
    @comment = Comment.new(:product_id => params[:product_id])
  end

  def create 
    @comment = current_user.comments.new(params[:comment])
    respond_to do |format|
      if @comment.save
        format.html {redirect_to product_path(@comment.product_id) }
      else
        format.html {render action: 'new'}
      end
    end
  end

  def destroy    
    respond_to do |format|
      if @comment.destroy
        flash[:notice] = 'Comment removed'
      else
        flash[:error] = 'Not allowed to remove this comment'
      end
      format.html { redirect_to request.referrer } 
    end
  end
end