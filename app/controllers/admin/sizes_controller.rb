class Admin::SizesController < Admin::BaseController
  before_filter(:only => [:destroy, :edit, :update]) { @size = Size.find(params[:id]) }
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
        format.html { redirect_to admin_sizes_path, flash: { success: 'New size '+@size.size+' created'} }
      else
        format.html { render action: new }
      end
    end
  end

  def edit
  end

  def update
    common_update(@size, admin_sizes_path, 'size')
  end

  def destroy
    @size.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Selected size deleted'  }
    end
  end
end