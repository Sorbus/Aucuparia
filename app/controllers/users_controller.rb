class UsersController < ApplicationController
	load_and_authorize_resource
 
	def index
		@users = User.paginate(:page => params[:page], :per_page => 20)
		render 'index'
	end

	def show
		@item = Item.find(params[:id])
		@posts = @user.items.paginate(:page => params[:page], :per_page => 5)
		render 'profiles/show'
	end
end