class CommentsController < ApplicationController

  before_filter :authorize_user
  before_filter :validate_user_before_delete, :only => :destroy

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
    @comment.destroy    
    respond_to do |format|
      format.html { redirect_to request.referrer, :notice => 'Comment removed'  } 
    end
  end
  
  private
    def validate_user_before_delete
      @comment = Comment.find(params[:id])
      unless (@comment.user_id == current_user.id) || current_user.admin
        redirect_to request.referrer, :notice => 'Not authorized to remove this comment'  
      end
    end
end