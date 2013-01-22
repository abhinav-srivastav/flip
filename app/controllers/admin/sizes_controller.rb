class Admin::SizesController < Admin::BaseController
  def index
    @sizes = Size.all
    respond_to do |format|
      format.html
    end
  end

  def new
    @size = Size.new
  end
  
  def create
    @size = Size.new(params[:size])
    respond_to do |format|
      if @size.save
      	flash[:success] = 'New size added'
        format.html { redirect_to admin_sizes_path }
      else
        format.html { render action: new }
      end
    end
  end

  def edit
    @size = Size.find(params[:id])
  end

  def update
    @size = Size.find(params[:id])
    respond_to do |format|
      if @size.update_attributes(params[:size])
        flash[:success] = 'size updated'
      	format.html { redirect_to admin_sizes_path }
      else
      	format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @size = Size.find(params[:id])
    @size.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'size deleted'  }
    end
  end
end