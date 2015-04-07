class Admin::CoreController < ApplicationController

	def index
	end

	def edit
		@page = Website.find(params[:id])
		authorize! :update, @page
	end
	
	def preview
#		@page = Website.new(page_params)
#		authorize! :edit, @page
	end
	
	def update
		@page = Website.find(params[:id])
		authorize! :update, @page
#		render plain: params[:item].inspect
		
		if can? :update, @page
			if params[:commit] == 'commit'
				if @page.update(page_params)
					redirect_to root_path
				else
					@page = Website.new(page_params)
					render 'preview'
				end
			else
				@page = Website.new(page_params)
				render 'preview'
			end
		else
			redirect_to new_user_session_path
		end
	end
	
	private
		def page_params
			params.require(:website).permit(:title, :content)
		end
end
