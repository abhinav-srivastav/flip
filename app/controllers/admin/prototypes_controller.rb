class Admin::PrototypesController < Admin::BaseController
  before_filter(:only => [:destroy, :edit, :update, :create_details]) { @prototype = Prototype.find(params[:id])  }
  def index 
		@prototypes = Prototype.all
		respond_to do |format|
			format.html
		end
	end
 
  def new
    @prototype = Prototype.new
  end

  def create 
    @prototype  = Prototype.new(params[:prototype])
    respond_to do |format|
      if @prototype.save
        format.html {redirect_to admin_prototypes_path, flash: { success: 'New prototype '+@prototype.name+' created'}}
      else
        format.html {render action: 'new'}
      end
    end
  end

  def edit
  end
  
  def update
    respond_to do |format|
      if @prototype.update_attributes(params[:prototype])
        @prototype.product_attribute_update
        format.html { redirect_to admin_prototypes_path, flash: { success: 'Prototype '+@prototype.name+' updated !'} }
      else
        format.html { render action: "edit"}
      end
    end
  end

  def destroy
    @prototype.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, :notice => 'Prototype deleted' }
    end
  end

  def create_details
    @prototype.add_attributes_to_product(params[:product_id])
    respond_to do |format|
      format.html { redirect_to request.referrer, flash: { success: 'Attributes updated for '+@prototype.name } }
    end
  end
end