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
    common_create(admin_brands_path, 'user')
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
      format.html { redirect_back_or_other_path(request.referrer, orders_path,{notice: 'selected user deleted'}) }
    end
  end
end