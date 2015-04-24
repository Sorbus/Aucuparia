class ProfilesController < ApplicationController
	def index
		if !current_user.blank?
			@user = current_user
			@posts = @user.items.paginate(:page => params[:page], :per_page => 5)
			respond_to do |format|
				format.js { render :action => 'show' }
				format.html { render :action => 'show' }
			end
		else
			redirect_to new_user_session_path
		end
	end

	def edit
		if !current_user.blank?
			@user = current_user
			respond_to do |format|
				format.js
				format.html
			end
		else
			redirect_to new_user_session_path
		end
	end
	
	def update
		if !current_user.blank?
			@user = current_user
			if @user.update_attributes(user_params)
				flash[:notice] = "Account updated!"
				redirect_to profile_path
			else
				flash[:alert] = "Account update failed."
				render 'edit'
			end
		else
			redirect_to new_user_session_path
		end
	end
	
	private
		def user_params
			params.require(:user).permit(:display_name, :biography, :website, :use_icon, :icon, :avatar)
		end
end
