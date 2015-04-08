class UsersController < ApplicationController
	load_and_authorize_resource :except => [:new, :create]
	
	def index
		@user = @current_user
		render :show
	end
	
	def new
		@user = User.new
	end
	
	def create
		@user = User.new(user_params)
		@token = RegistrationToken.find_by_token(params[:user][:access_token])
#		render plain: params[:user].inspect
#		render plain: @token.inspect
		if !@token.nil?
			if !@token.used
				if @user.save
					@token.used = true
					@token.user_id = @user.id
					@token.save
					flash[:notice] = "Account registered!"
					redirect_to @user
				else
					render 'new'
				end
			else
				@user.errors.add(:access_token, "has already been used")
				render 'new'
			end
		else
			@user.errors.add(:access_token, "does not exist")
			render 'new'
		end
	end
	
	def show
		@user = User.find(params[:id])
		@posts = @user.items.paginate(:page => params[:page], :per_page => 5)
	end

	def edit
		@user = @current_user
	end
	
	def update
		@user = @current_user
		if !params[:user][:password].blank? or (params[:user][:email].to_s != @user.email.to_s)
			if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
				params[:user].delete("password")
				params[:user].delete("password_confirmation")
			end
			if @current_user.valid_password?(params[:user][:old_password])
				if @user.update_attributes(user_params)
					flash[:notice] = "Account updated!"
					redirect_to @user
				else
					render 'edit'
				end
			else
				@user.errors.add(:old_password, "is not valid")
				render 'edit'
			end
		else
			params[:user].delete("password")
			params[:user].delete("password_confirmation")
			params[:user].delete("email")
			if @user.update_attributes(user_params)
				flash[:notice] = "Account updated!"
				redirect_to @user
			else
				render 'edit'
			end
		end
	end
	
	private
		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation, :display_name, :biography, :website)
		end
end