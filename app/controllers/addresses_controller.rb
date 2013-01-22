class AddressesController < ApplicationController

  before_filter :authorize_user

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

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, :notice => 'Address deleted !'  }
    end 
  end

end
