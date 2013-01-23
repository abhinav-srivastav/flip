class Admin::SessionsController < Admin::BaseController
  layout 'application'
  skip_before_filter :authorize_admin
  def new
    @@from_page = request.referrer
  end

  def create
    @@from_page ||= ''
  	valid_user = User.authorize(params[:username], params[:password])
  	if valid_user
  		session[:user_id] = valid_user.id
      redirect_to @@from_page
    else
      render 'new'
    end
  end

  def destroy
  	reset_session
    flash[:success] = 'logged out successfully'
    redirect_to :root
  end
end
