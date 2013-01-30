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
    common_create( admin_sizes_path, 'size')
  end

  def edit
  end

  def update
    common_update(@size, admin_sizes_path, 'size')
  end

  def destroy
    common_destroy(@size, request.referrer, admin_sizes_path, {notice: 'selected size deleted'})
  end
end