class CommentsController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
  before_filter :user_authorize
  
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




end
