class Admin::UsersController < Admin::BaseController
  before_filter(:only => [:destroy, :edit, :update]) { @user = User.find(params[:id]) }
  def index
  	@users = User.normals
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
        format.html {redirect_to admin_users_path, flash: { success: 'New user '+@user.username+' created'}}
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
        format.html { redirect_to admin_users_path, flash: { success: 'Details for '+@user.username+' updated !'} }
      else
        format.html { render action: "edit"}
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, :notice => 'Selected user deleted' }
    end
  end
end