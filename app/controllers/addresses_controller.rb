class AddressesController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
  before_filter :user_authorize

  def new
  	@@order_page_path = request.referrer
    @address = Address.new()
  end

  def create 
  	@@order_page_path ||= '/orders'
    @address = Address.new(params[:address])
    @address.user_id = current_user.id
    unless @address.save
      flash[:error] = 'Invalid address'
    end
    respond_to do |format|
      format.html { redirect_to @@order_page_path }
    end
  end

end