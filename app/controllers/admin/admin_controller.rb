class Admin::AdminController < ApplicationController
	def index
		authorize! :see, :admin_tools
		respond_to do |format|
			format.js { render :action => 'index' }
			format.html { render :action => 'index' }
		end
	end
end
