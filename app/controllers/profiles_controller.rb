class ProfilesController < ApplicationController
	def index
		if !current_user.blank?
			@user = current_user
			@posts = @user.items.where(:published => true, :deleted => false).page params[:page]
			@unpub = @user.items.where(:published => false, :deleted => false)
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
				flash[:success] = I18n.t(:noti_account_updated)
				redirect_to profile_path
			else
				flash[:error] = I18n.t(:noti_account_update_failed)
				render 'edit'
			end
		else
			flash[:alert] = I18n.t(:noti_no_permissions)
			redirect_to new_user_session_path
		end
	end
	
	private
		def user_params
			params.require(:user).permit(:display_name, :biography, :website, :use_icon, :icon, :avatar)
		end
end
