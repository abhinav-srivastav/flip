class Admin::CategoriesController < Admin::BaseController
  before_filter(:only => [:destroy, :update]) { @category = Category.find(params[:id]) }
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
    common_create(admin_categories_path, 'category')
  end

	def edit 
    @category = Category.includes(:products, :brands).find(params[:id])
	end
	
  def update
    common_update(@category, admin_categories_path, 'category')		
	end

  def destroy
    common_destroy(@category, request.referrer, admin_categories_path, {notice: 'selected category deleted'})
  end
end