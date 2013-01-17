class Admin::PrototypesController < ApplicationController
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
        format.html {redirect_to admin_prototypes_path}
      else
        format.html {render action: 'new'}
      end
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end
  
  def update
    @prototype = Prototype.find(params[:id])
    respond_to do |format|
      if @prototype.update_attributes(params[:prototype])
        @prototype.products.each do |pro|
          @prototype.product_attributes.each do |pa|
            pro.add_details(pa.id)
          end
        end
        flash[:success] = "Prototype updated !"
        format.html { redirect_to admin_prototypes_path }
      else
        format.html { render action: "edit"}
      end
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, :notice => 'Prototype deleted' }
    end
  end

  def create_details
    @prototype = Prototype.find(params[:id])
    @product = Product.find(params[:product_id])
    @prototype.products << @product
    @prototype.product_attributes.each do |pa|
      @product.add_details(pa.id)
    end
    respond_to do |format|
      format.html { redirect_to request.referrer }
    end
  end


end
