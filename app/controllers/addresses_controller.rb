class AddressesController < ApplicationController

  before_filter :authorize_user

  def new
    @address = Address.new()
  	@@order_page_path = request.referrer
  end

  def create 
    @address = current_user.addresses.new(params[:address])
    @@order_page_path ||= '/orders'
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
