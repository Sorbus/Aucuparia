class ProfilesController < ApplicationController
	load_and_authorize_resource :except => [:new, :create]
	
	def index
		@user = @current_user
		render :show
	end
	
	def show
		if !params[:id].present?
			@user = User.find(current_user.id)
		else
			@user = User.find(params[:id])
		end
		@posts = @user.items.paginate(:page => params[:page], :per_page => 5)
	end

	def edit
		@user = @current_user
	end
	
	def update
		@user = @current_user
		if @user.update_attributes(user_params)
			flash[:notice] = "Account updated!"
			redirect_to profile_path
		else
			flash[:alert] = "Account update failed."
			render 'edit'
		end
	end
	
	private
		def user_params
			params.require(:user).permit(:display_name, :biography, :website)
		end
end