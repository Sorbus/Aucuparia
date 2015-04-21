class Admin::LogolinkController < ApplicationController
	before_filter :authenticate_user!

	def index
		authorize! :update, ::Logolink
		@logolinks = Logolink.find_each
		@ll_new = Logolink.new
	end
	
	def create
		@ll_new = Logolink.new(ll_params)
		authorize! :create, @ll_new
		if @ll_new.save
			flash[:notice] = "Logolink successfully created."
			redirect_to admin_logolink_index_path
		else
			flash[:alert] = "Logolink creation failed!"
			redirect_to admin_logolink_index_path
		end
	end
	
	def update
		@ll_up = Logolink.find(params[:id])
		authorize! :update, @ll_up
#		render plain: params[:item].inspect
		
		if @ll_up.update(ll_params)
			flash[:notice] = "Logolink successfully updated."
			redirect_to admin_logolink_index_path
		else
			flash[:alert] = "Logolink update failed!"
			redirect_to admin_logolink_index_path
		end
	end
	
	def destroy
		@ll_del = Logolink.find(params[:id])
		if can? :destroy, @ll_del
			@ll_del.destroy
			flash[:notice] = "Logolink destroyed"
			redirect_to admin_logolink_index_path
		else
			flash[:alert] = "You can't do that!"
			redirect_to root_path
		end
	end
	
	private
		def ll_params
			params.require(:logolink).permit(:url, :css_id, :css_class, :display)
		end
end
