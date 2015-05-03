class UsersController < ApplicationController
	load_and_authorize_resource
	before_filter :authenticate_user!, :except => [:index, :show]
 
	def index
		@users = User.page params[:page]
		respond_to do |format|
			format.js
			format.html
		end
	end

	def show
		#@user = User.find_by_id(params[:id])
		@posts = @user.items.where(:published => true, :deleted => false).page params[:page]
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def edit
		#@user = User.find(params[:id])
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def update
		#@user = User.find(params[:id])
		User.valid_roles.each do |role|
			if params[:roles].has_key?(role.to_s) && (can? :assign, role)
				if params[:roles][role.to_s] == 'true'
					@user.roles.add(role)
				else
					@user.roles.delete(role)
				end
			end
		end
		if @user.update_without_password(user_params)
			flash[:success] = I18n.t(:noti_updated)
			redirect_to user_path(@user)
		else
			flash[:error] = I18n.t(:noti_update_failed)
			redirect_to edit_user_path(@user)
		end
	end
	
	private
		def user_params
			params.require(:user).permit(:display_name, :biography, :website, :use_icon, :icon, :avatar)
		end
end