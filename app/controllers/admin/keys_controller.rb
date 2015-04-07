class Admin::KeysController < ApplicationController

	def index
		authorize! :index, RegistrationToken
		@keys = RegistrationToken.find_each(start: ((params[:page].to_i - 1) * 10), batch_size: 10)
		@pages = RegistrationToken.paginate(:page => params[:page], :per_page => 10)
	end
	
	def new
		@key = RegistrationToken.new
		authorize! :create, @key
	end
	
	def create
		@key = RegistrationToken.new(key_params)
		@key.token = SecureRandom.hex
		@key.used = false
		authorize! :create, @key
		if @key.save
			redirect_to admin_keys_path
		else
			render 'new'
		end
	end
	
	def destroy
		@key = RegistrationToken.find(params[:id])
		if can? :destroy, @key
			@key.destroy
			redirect_to admin_keys_path
		else
			redirect_to user_sessions_root_path
		end
	end
	
	private
		def key_params
			params.require(:registration_token).permit(:access_tier)
		end
end
