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
        if @group.update(group_params)
            flash[:sucess] = I18n.t(:noti_updated)
            redirect_to group_path(@group)
        else
            flash[:error] = I18n.t(:noti_update_failed)
            redirect_to group_path(@group)
        end
	end
	
	def destroy
        @group.users.each do |user|
            user.groups.destroy(@group)
        end
        @group.destroy
        flash[:sucess] = I18n.t(:noti_deleted)
        redirect_to groups_path
	end
    
    def add
        @group = Group.find(params[:group_id])
        @user = User.find(params[:user_id])
    end
    
    def remove
        @group = Group.find(params[:group_id])
        @user = User.find(params[:user_id])
    end
    
    def power
        @group = Group.find(params[:group_id])
        @user = User.find(params[:user_id])
    end
	
	private 
	
		def group_params
			params.require(:group).permit(:title)
		end
end
