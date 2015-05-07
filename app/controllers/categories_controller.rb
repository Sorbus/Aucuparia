class CategoriesController < ApplicationController
	load_and_authorize_resource

	def index
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def show
		@posts = @category.items.where(:deleted => false, :published => true).page params[:page]
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def new
		@menu_options = Menu.all.map{|c| [ c.title, c.id ] }
		respond_to do |format|
			format.js
			format.html
		end
	end

	def edit
		@menu_options = Menu.all.map{|c| [ c.title, c.id ] }
		respond_to do |format|
			format.js
			format.html
		end
	end
 
	def create
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
		@category.destroy
		flash[:success] = I18n.t(:noti_category_deleted)
		redirect_to categories_path
	end
	
	private
		def category_params
			params.require(:category).permit(:name, :summary, :menu_id)
		end
end