class Admin::LogolinkController < ApplicationController
	before_filter :authenticate_user!

	def index
		authorize! :update, ::Logolink
		@logolinks = Logolink.find_each
		@ll_new = Logolink.new
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def create
		authorize! :create, ::Logolink
		@ll_new = Logolink.new(ll_params)
		if @ll_new.save
			current_user.notify('success',I18n.t(:noti_created))
			redirect_to admin_logolink_index_path
		else
			current_user.notify('error',I18n.t(:noti_creation_failed))
			redirect_to admin_logolink_index_path
		end
	end
	
	def update
		@ll_up = Logolink.find(params[:id])
		authorize! :update, @ll_up
		if @ll_up.update(ll_params)
			current_user.notify('success',I18n.t(:noti_updated))
			redirect_to admin_logolink_index_path
		else
			current_user.notify('error',I18n.t(:noti_update_failed))
			redirect_to admin_logolink_index_path
		end
	end
	
	def destroy
		@ll_del = Logolink.find(params[:id])
		if can? :destroy, @ll_del
			@ll_del.destroy
			current_user.notify('success',I18n.t(:noti_deleted))
			redirect_to admin_logolink_index_path
		else
			current_user.notify('error',I18n.t(:noti_deletion_failed))
			redirect_to root_path
		end
	end
	
	private
		def ll_params
			params.require(:logolink).permit(:url, :css_id, :css_class, :display)
		end
end
