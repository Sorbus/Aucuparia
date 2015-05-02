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
			respond_to do |f| 
				f.html{ redirect_to item_lock_index_path(@item) }
				f.js
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
			respond_to do |f| 
				f.html{ redirect_to item_lock_index_path(@item) }
				f.js
			end
		else
			redirect_to new_user_session_path
		end
	end
end
