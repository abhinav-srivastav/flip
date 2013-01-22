class Admin::VarientsController < Admin::BaseController
  before_filter(:only => [:destroy, :edit, :update]) { @varient = Varient.find(params[:id]) }
  def new
    @varient = Varient.new
    @@product_id = params[:product_id]
  end

  def create
    @varient = Varient.new(params[:varient])
    @varient.product_id = @@product_id
    respond_to do |format|
      if @varient.save
        flash[:success] = 'varient added'
        format.html { redirect_to edit_admin_product_path(@varient.product) }
      else
        format.html {  render action: 'new' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @varient.update_attributes(params[:varient])
      	flash[:success] = 'varient updated'
      	format.html { redirect_to edit_admin_product_path(@varient.product) } 
      else
      	format.html { render action: 'edit' }
      end
    end
  end
  def destroy
    @varient.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, :notice => 'varient deleted' } 
    end
  end
end