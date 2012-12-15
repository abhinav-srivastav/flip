class Admin::SessionsController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize

  def new
  end

  def create
  	valid_user = User.authorize(params[:username], params[:password])
  	if valid_user
  		session[:user_id] = valid_user.id
      redirect_to :root
    else
      render 'new'
    end
  end

  def destroy
  	reset_session
    redirect_to :root
  end
end
