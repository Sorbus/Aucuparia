class CategoriesController < ApplicationController
	load_and_authorize_resource

	def index
		@categories = Category.all
	end
	
	def show
		@category = Category.find(params[:id])
		@posts = @category.items.paginate(:page => params[:page], :per_page => 5)
	end
	
	def new
		@category = Category.new
		@menu_options = Menu.all.map{|c| [ c.title, c.id ] }
	end

	def edit
		@category = Category.find(params[:id])
		@menu_options = Menu.all.map{|c| [ c.title, c.id ] }
	end
 
	def create
		@category = Category.new(category_params)
		@menu_options = Menu.all.map{|c| [ c.title, c.id ] }
	  
		if @category.save
			redirect_to @category
		else
			render 'new'
		end
	end
	
	def update
		@category = Category.find(params[:id])
		@menu_options = Menu.all.map{|c| [ c.title, c.id ] }
 
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
			params.require(:category).permit(:name, :summary, :menu_id)
		end
end