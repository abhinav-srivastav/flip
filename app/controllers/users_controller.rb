class UsersController < ApplicationController

  before_filter :authorize_user, :except => [:new, :create]
  def show
  	@user = User.find(params[:id])
  	respond_to do |format|
  	  format.html
  	end
  end

  def new
    @user = User.new
  end

  def create 
    @user  = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to :root }
      else
        format.html {render action: 'new'}
      end
    end
  end

  def edit
  	@user = User.find(params[:id])
  	unless @user.id.to_i == current_user.id.to_i
  	  redirect_to :root, notice: 'Not authorized.'
  	end 
  end

  def update
  	@user = User.find(params[:id])
	  respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_path(@user), :notice => "Updated"}
      else
        format.html { render action: "edit"}
      end
    end
  end

end
