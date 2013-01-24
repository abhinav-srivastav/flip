class UsersController < ApplicationController

  before_filter :authorize_user, :except => [:new, :create]
  before_filter(:only => [:show, :edit, :update]) { @user = User.find(params[:id]) }
  before_filter :authorize_user_to_edit, :only => :edit

  def show
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
        render action: 'new'
      end
    end
  end

  def edit 
  end

  def update
	  respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_path(@user), :notice => "Updated"}
      else
        format.html { render action: "edit"}
      end
    end
  end
  private
    def authorize_user_to_edit
      unless @user.id.to_i == current_user.id.to_i
        redirect_to :root, flash: { error: current_user.username+',you are not authorized to edit other user\' account.'}
      end
    end 
end