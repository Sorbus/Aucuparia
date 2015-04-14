class Admin::UsersController < ApplicationController
	before_filter :authenticate_user!

	def show
		@user = User.find(params[:id])
		authorize! :edit, @key
	end
	
	def edit
		@user = User.find(params[:id])
		authorize! :update, @key
	end
	
	def update
		@user = User.find(params[:id])
		authorize! :update, @key
	end
	
	def destroy
		@user = User.find(params[:id])
		authorize! :destroy, @key
	end
end
