class CategoriesController < ApplicationController
	load_and_authorize_resource

	def index
		@categories = Category.all
	end
	
	def show
		@category = Category.find(params[:id])
		@items = @category.items.find_each(start: ((params[:page].to_i - 1) * 5), batch_size: 5)
		@posts = @category.items.paginate(:page => params[:page], :per_page => 5)
	end
	
	def new
		@category = Category.new
		@menu_options = Website.all.map{|c| [ c.menu_title, c.id ] }
	end

	def edit
		@category = Category.find(params[:id])
		@menu_options = Website.all.map{|c| [ c.menu_title, c.id ] }
	end
 
	def create
		@category = Category.new(category_params)
		@menu_options = Website.all.map{|c| [ c.menu_title, c.id ] }
	  
		if @category.save
			redirect_to @category
		else
			render 'new'
		end
	end
	
	def update
		@category = Category.find(params[:id])
		@menu_options = Website.all.map{|c| [ c.menu_title, c.id ] }
 
		if @category.update(category_params)
			redirect_to @category
		else
			render 'edit'
		end
	end
	
	def destroy
		@category = Category.find(params[:id])
		@category.destroy
 
		redirect_to categories_path
	end
	
	private
		def category_params
			params.require(:category).permit(:name, :summary, :website_id)
		end
end