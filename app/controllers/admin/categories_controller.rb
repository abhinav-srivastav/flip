class Admin::CategoriesController < Admin::BaseController
  before_filter(:only => [:destroy, :edit, :update]) { @category = Category.find(params[:id]) }
	def index 
		@categories = Category.all
		respond_to do |format|
			format.html
		end
	end
 
  def new
    @category = Category.new
  end

  def create 
    @category  = Category.new(params[:category])
    respond_to do |format|
      if @category.save
        format.html {redirect_to admin_categories_path, flash: { success: 'New category '+@category.category+' created'}  }
      else
        format.html {render action: 'new'}
      end
    end
  end

	def edit 
	end
	
  def update
		respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to admin_categories_path, flash: { success: 'Category '+@category.category+' updated !'} }
      else
        format.html { render action: "edit"}
      end
    end
	end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, flash: { notice: 'Selected category deleted'} }
    end
  end
end