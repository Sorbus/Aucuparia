class Admin::MenusController < ApplicationController
	before_filter :authenticate_user!

	def index
		authorize! :update, ::Menu
		@menus = Menu.find_each
		@menu = Menu.new
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def new
		redirect_to admin_menus_path
	end
	
	def create
		authorize! :create, ::Menu
		@menu = Menu.new(menu_params)
		if @menu.save
			flash[:notice] = "Menu successfully created."
		else
			flash[:alert] = "Menu creation failed!"
		end
		redirect_to admin_menus_path
	end
	
	def update
		@menu = Menu.find(params[:id])
		authorize! :update, @menu
		if @menu.update(menu_params)
			flash[:notice] = "Menu successfully updated."
		else
			flash[:alert] = "Menu update failed!"
		end
		redirect_to admin_menus_path
	end
	
	private
		def menu_params
			params.require(:menu).permit(:title, :visible)
		end
end
