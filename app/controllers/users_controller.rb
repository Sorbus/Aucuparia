class UsersController < ApplicationController
	load_and_authorize_resource
	before_filter :authenticate_user!, :except => [:index, :show]
 
	def index
		@users = User.paginate(:page => params[:page], :per_page => 20)
		respond_to do |format|
			format.js
			format.html
		end
	end

	def show
		@item = Item.find(params[:id])
		@posts = @user.items.paginate(:page => params[:page], :per_page => 5)
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def edit
		@user = User.find(params[:id])
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def update
		@user = User.find(params[:id])
		User.valid_roles.each do |role|
			if params[:roles].has_key?(role.to_s) && (can? :assign, role)
				if params[:roles][role.to_s] == 'true'
					@user.roles.add(role)
				else
					@user.roles.delete(role)
				end
			end
		end
		if @user.update_attributes(user_params)
			flash[:notice] = "Account updated!"
			redirect_to user_path(@user)
		else
			flash[:alert] = "Account update failed."
			render 'edit'
		end
	end
	
	private
		def user_params
			params.require(:user).permit(:display_name, :biography, :website, :use_icon, :icon, :avatar)
		end
end