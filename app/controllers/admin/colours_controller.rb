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
    @colour = Colour.new(params[:colour])
    respond_to do |format|
      if @colour.save
        format.html { redirect_to admin_colours_path, flash: { success: 'New colour '+@colour.colour+' created'}}
      else
        format.html { render action: new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @colour.update_attributes(params[:colour])
      	format.html { redirect_to admin_colours_path, flash: { success: 'Colour '+@colour.colour+' updated !'} }
      else
      	format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @colour.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Colour deleted'  }
    end
  end
end