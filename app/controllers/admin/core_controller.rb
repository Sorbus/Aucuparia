class Admin::CoreController < ApplicationController

	def index
		authorize! :update, Core
	end

	def edit
		@page = Core.find(params[:id])
		authorize! :update, @page
	end
	
	def preview
#		@page = Website.new(page_params)
#		authorize! :edit, @page
	end
	
	def update
		@page = Core.find(params[:id])
		authorize! :update, @page
#		render plain: params[:item].inspect
		
		if params[:commit] == 'commit'
			if @page.update(page_params)
				redirect_to root_path
			else
				@page = Core.new(page_params)
				render 'preview'
			end
		else
			@page = Core.new(page_params)
			render 'preview'
		end
	end
	
	private
		def page_params
			params.require(:core).permit(:title, :content)
		end
end
