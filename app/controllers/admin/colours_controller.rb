class Admin::ColoursController < Admin::BaseController
  before_filter(:only => [:destroy, :edit, :update]) { @colour = Colour.find(params[:id]) }
  def index
    @colours = Colour.all
    respond_to do |format|
      format.html
    end
  end

  def new
    @colour = Colour.new
  end
  
  def create
    common_create(admin_colours_path, 'colour')
  end

  def edit
  end

  def update
    common_update(@colour, admin_colours_path, 'colour')
  end

  def destroy
    @colour.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Colour deleted'  }
    end
  end
end