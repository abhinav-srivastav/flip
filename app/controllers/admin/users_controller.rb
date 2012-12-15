class Admin::UsersController < ApplicationController
  def index
  	@users = User.all
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
        format.html {redirect_to admin_users_path}
      else
        format.html {render action: 'new'}
      end
    end
  end

	def edit 
		@user = User.find(params[:id])
	end
	
  def update
		@user = User.find(params[:id])
		respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_users_path }
      else
        format.html { render action: "edit"}
      end
    end
  end

end
