class Admin::SessionsController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
  @@from_page
  def new
    logger.info(request.referrer)
    @@from_page = request.referrer
    logger.info(@@from_page)
  end

  def create
    logger.info('hcvyg')
    logger.info(@@from_page)
  	valid_user = User.authorize(params[:username], params[:password])
  	if valid_user
  		session[:user_id] = valid_user.id
      redirect_to  @@from_page
    else
      render 'new'
    end
  end

  def destroy
  	reset_session
    redirect_to :root
  end
end
