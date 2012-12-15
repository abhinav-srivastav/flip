class Admin::SessionsController < ApplicationController
  layout 'public'
  def new
  end

  def create
  	valid_user = User.authorize(params[:username], params[:password])
  	if valid_user
  		session[:user_id] = valid_user.id
      redirect_to admin_categories_path
    else
      render 'new'
    end
  end

  def destroy
  	reset_session
    redirect_to :root

  end
end
