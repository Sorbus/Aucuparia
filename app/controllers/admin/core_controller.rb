class Admin::CoreController < ApplicationController

	def index
		authorize! :update, StaticPage
	end

	def edit
		@page = StaticPage.find(params[:id])
		authorize! :update, @page
	end
	
	def preview
#		@page = Website.new(page_params)
#		authorize! :edit, @page
	end
	
	def update
		@page = StaticPage.find(params[:id])
		authorize! :update, @page
#		render plain: params[:item].inspect
		
		if params[:commit] == 'commit' && @page.update(page_params)
			flash[:notice] = "Page updated"
			redirect_to root_path
		else
			@page = StaticPage.new(page_params)
			render 'preview'
		end
	end
	
	private
		def page_params
			params.require(:core).permit(:title, :content)
		end
end
