class AddressesController < ApplicationController

  before_filter :authorize_user
  def new
    @address = Address.new
  	@@order_id = params[:order_id]
  end

  def create 
    @address = current_user.addresses.new(params[:address])
    unless @address.save
      flash[:error] = 'Invalid address'
    end
    respond_to do |format|
      format.html { redirect_to confirm_order_path(@@order_id) }
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    respond_to do |format|
      format.html { redirect_back_or_other_path(request.referrer,cart_orders_path,{:notice => 'Address deleted !'} ) }
    end 
  end

end
