class Admin::SessionsController < Admin::BaseController
  layout 'application'
  skip_before_filter :authorize_admin
  def new
    @@from_page = request.referrer
  end

  def create
  	valid_user = User.authorize(params[:username], params[:password])
  	if valid_user
  		session[:user_id] = valid_user.id
      redirect_to @@from_page
    else
      render action: 'new'
    end
  end

  def destroy
  	reset_session
    redirect_to :root, flash: {success: 'logged out successfully'}
  end
end
