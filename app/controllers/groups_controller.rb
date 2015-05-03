class GroupsController < ApplicationController
	load_and_authorize_resource
	before_filter :authenticate_user!

	def index
		@groups = current_user.groups
	end
	
	def show
	end
	
	def new
	end
	
	def edit
	end
	
	def create
		@group = Group.new(group_params)
		if @group.save
			@group.add(current_user, as: 'manager')
			flash[:success] = I18n.t(:noti_created)
			redirect_to group_path(@group)
		else
			flash[:error] = I18n.t(:noti_creation_failed)
			redirect_to new_group_path
		end
	end
	
	def update
	end
	
	def destroy
	end
	
	private 
	
		def group_params
			params.require(:group).permit(:title)
		end
end
