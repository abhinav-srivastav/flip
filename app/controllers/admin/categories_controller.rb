class Admin::CategoriesController < ApplicationController
	def index 
		@categories = Category.all
		respond_to do |format|
			format.html
		end
	end
end
