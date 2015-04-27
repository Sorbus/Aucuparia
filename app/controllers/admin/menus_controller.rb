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
			current_user.notify('success',I18n.t(:noti_created))
			redirect_to admin_menus_path
		else
			current_user.notify('error',I18n.t(:noti_creation_failed))
			redirect_to admin_menus_path
		end
	end
	
	def update
		@menu = Menu.find(params[:id])
		authorize! :update, @menu
		if @menu.update(menu_params)
			current_user.notify('success',I18n.t(:noti_updated))
			redirect_to admin_menus_path
		else
			current_user.notify('error',I18n.t(:noti_update_failed))
			redirect_to admin_menus_path
		end
	end
	
	private
		def menu_params
			params.require(:menu).permit(:title, :visible)
		end
end
