class CategoriesController < ApplicationController
	load_and_authorize_resource
	before_filter :authenticate_user!, :except => [:index, :show]

	def index
		#@categories = Category.all
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def show
		#@category = Category.find(params[:id])
		@posts = @category.items.where(:deleted => false, :published => true).paginate(:page => params[:page], :per_page => 5)
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def new
		#@category = Category.new
		@menu_options = Menu.all.map{|c| [ c.title, c.id ] }
		respond_to do |format|
			format.js
			format.html
		end
	end

	def edit
		#@category = Category.find(params[:id])
		@menu_options = Menu.all.map{|c| [ c.title, c.id ] }
		respond_to do |format|
			format.js
			format.html
		end
	end
 
	def create
		@category = Category.new(category_params)
		@menu_options = Menu.all.map{|c| [ c.title, c.id ] }
		if @category.save
			flash[:success] = I18n.t(:noti_category_created)
			redirect_to @category
		else
			flash[:error] = I18n.t(:noti_creation_failed)
			render 'new'
		end
	end
	
	def update
		#@category = Category.find(params[:id])
		@menu_options = Menu.all.map{|c| [ c.title, c.id ] }
		if @category.update(category_params)
			flash[:success] = I18n.t(:noti_category_updated)
			redirect_to @category
		else
			flash[:success] = I18n.t(:noti_update_failed)
			render 'edit'
		end
	end
	
	def destroy
		#@category = Category.find(params[:id])
		@category.destroy
		flash[:success] = I18n.t(:noti_category_deleted)
		redirect_to categories_path
	end
	
	private
		def category_params
			params.require(:category).permit(:name, :summary, :menu_id)
		end
end