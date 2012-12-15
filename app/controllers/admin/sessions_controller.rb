class Admin::SessionsController < ApplicationController
  def new
  end

  def create
  	valid_user = User.authorize(params[:username], params[:password])
  	if valid_user
  		session[:user_name] = valid_user.username
      redirect_to admin_categories_path
    else
      render 'new'
    end
  end

  def destroy
  	reset_session

  end
end
