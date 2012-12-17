class UsersController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
  before_filter :user_authorize
  def show
  	@user = User.find(params[:id])
  	respond_to do |format|
  	  format.html
  	end
  end
end
