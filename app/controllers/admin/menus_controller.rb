class Admin::MenusController < ApplicationController
	def index
		authorize! :update, ::Menu
		@menus = Menu.find_each
		@menu = Menu.new
	end
	
	def new
		redirect_to admin_menus_path
	end
	
	def create
		@menu = Menu.new(menu_params)
		authorize! :create, @menu
		if @menu.save(menu_params)
			flash[:notice] = "Menu successfully created."
			redirect_to admin_menus_path
		else
			flash[:notice] = "Menu creation failed!"
			redirect_to admin_root_path
		end
	end
	
	def update
		@menu = Menu.find(params[:id])
		authorize! :update, @menu
#		render plain: params[:item].inspect
		
		if @menu.update(menu_params)
			flash[:notice] = "Menu successfully updated."
			redirect_to admin_menus_path
		else
			flash[:notice] = "Menu update failed!"
			redirect_to admin_root_path
		end
	end
	
	private
		def menu_params
			params.require(:menu).permit(:title, :visible)
		end
end
