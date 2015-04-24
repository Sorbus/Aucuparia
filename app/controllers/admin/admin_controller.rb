class Admin::AdminController < ApplicationController
	def index
		authorize! :see, :admin_tools
		respond_to do |format|
			format.js
			format.html
		end
	end
end
