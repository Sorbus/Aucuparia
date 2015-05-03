class LocksController < ApplicationController
	before_filter :authenticate_user!
	
	load_and_authorize_resource :item

	def index
	end
	
	def add
		@group = Group.find_by_id(params[:lock_id])
		@item = Item.find_by_id(params[:item_id])
		if can? :update, @item
			@group.add(@item)
			flash[:success] = I18n.t(:noti_group_added)
			respond_to do |f| 
				f.html { redirect_to item_lock_index_path(@item) }
				f.js { render 'index' }
			end
		else
			redirect_to new_user_session_path
		end
	end
	
	def remove
		@group = Group.find_by_id(params[:lock_id])
		@item = Item.find_by_id(params[:item_id])
		if can? :update, @item
			@group.items.destroy(@item)
			flash[:success] = I18n.t(:noti_group_removed)
			respond_to do |f| 
				f.html{ redirect_to item_lock_index_path(@item) }
				f.js { render 'index' }
			end
		else
			redirect_to new_user_session_path
		end
	end
end
