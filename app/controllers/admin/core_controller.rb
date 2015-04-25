class Admin::CoreController < ApplicationController
	before_filter :authenticate_user!

	def edit
		@page = StaticPage.find(params[:id])
		authorize! :update, @page
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def update
		@page = StaticPage.find(params[:id])
		authorize! :update, @page
		if params[:commit] == 'commit' && @page.update(page_params)
#			flash[:notice] = "Page updated"
			redirect_to root_path
		else
			@page = StaticPage.new(page_params)
			@page.id = params[:id]
			render 'edit'
		end
	end
	
	private
		def page_params
			params.require(:static_page).permit(:title, :content)
		end
end
