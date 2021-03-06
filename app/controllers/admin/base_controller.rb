class Admin::BaseController < ApplicationController
 layout 'admin'

 before_filter :authorize_admin
 helper_method :admin_logged_in?

 private

  def authorize_admin
  	unless admin_logged_in?
  		redirect_to :root
  	end
  end

  def admin_logged_in?
  	user_signed_in? && current_user.admin
  end

  def common_update(instance, return_path, field)
    respond_to do |format|
      if instance.update_attributes(params[field.to_sym])
        format.html { redirect_to return_path, flash: { success: field.capitalize+' '+instance[field]+' updated !'  } }
      else
        format.html { render action: "edit"}
      end
    end
  end

  def common_create(return_path, field)
    @instance = field.capitalize.constantize.new(params[field.to_sym])
    respond_to do |format|
      if @instance.save
        format.html { redirect_to return_path, flash: { success: 'New '+field.capitalize+' '+@instance[field]+' created !'  } }
      else
        format.html { render action: "edit"}
      end
    end
  end

  def common_destroy(instance, return_path, optional_path, msg ={})
    instance.destroy
    respond_to do |format|
      format.html { redirect_back_or_other_path(return_path, optional_path, msg )  } 
    end
  end


end