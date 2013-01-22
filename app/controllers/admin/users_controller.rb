class Admin::UsersController < Admin::BaseController
  before_filter(:only => [:destroy, :edit, :update]) { @user = User.find(params[:id]) }
  def index
  	@users = User.normal_users
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
	end
	
  def update
		respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_users_path, :notice => "user updated !" }
      else
        format.html { render action: "edit"}
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer }
    end
  end
end