class Admin::AdminController < ApplicationController
	def index
		authorize! :see, :admin_tools
		render 'admin/index'
	end
end
