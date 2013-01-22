class CommentsController < ApplicationController

  before_filter :authorize_user
  
  def new
    @comment = Comment.new
    @@product_id = params[:product_id]
  end

  def create 
    @comment = Comment.new(params[:comment])
    @comment.product_id = @@product_id
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html {redirect_to product_path(@comment.product) }
      else
        format.html {render action: 'new'}
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id == current_user.id || current_user.admin
      @comment.destroy
      flash[:notice] = 'Comment removed'
    else
      flash[:notice] = 'Not authorized to remove this comment'
    end
    respond_to do |format|
      format.html { redirect_to request.referrer  } 
    end
  end




end
