class ItemsController < ApplicationController
	load_and_authorize_resource
#	before_action :require_user, except: [:index, :show]
	before_filter :authenticate_user!, :except => [:index, :show]

	def index 
		@posts = Item.paginate(:page => params[:page], :per_page => 5)
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def show
		@item = Item.find(params[:id])
		@comment = Comment.new
		@comment.item_id = @item.id
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def new
		@item = Item.new
		@cat_options = Category.all.map{|c| [ c.name, c.id ] }
		respond_to do |format|
			format.js
			format.html
		end
	end

	def edit
		@item = Item.find(params[:id])
		@cat_options = Category.all.map{|c| [ c.name, c.id ] }
		respond_to do |format|
			format.js
			format.html
		end
	end
 
	def create
		@item = Item.new(item_params)
		@item.category = Category.find(params[:item][:category_id])
		@item.user = User.find(current_user.id)
#		render plain: params[:item].inspect
		
		if params[:commit] == 'commit' && @item.save
			current_user.notify('success',I18n.t(:noti_item_created))
			redirect_to @item
		else
			@cat_options = Category.all.map{|c| [ c.name, c.id ] }
			render 'new'
		end
	end
	
	def update
		@item = Item.find(params[:id])
		@item.category = Category.find(params[:item][:category_id])
#		render plain: params[:item].inspect
		
		if can? :update, @item
			if (params[:commit] == 'commit') && @item.update(item_params)
				current_user.notify('success',I18n.t(:noti_item_updated))
				redirect_to @item
			else
				@item = Item.new(item_params)
				@cat_options = Category.all.map{|c| [ c.name, c.id ] }
				render 'edit'
			end
		else
			current_user.notify('warning',I18n.t(:noti_no_permissions))
			redirect_to @item
		end
	end
	
	def destroy
		@item = Item.find(params[:id])
		if can? :destroy, @item
			@item.destroy
			current_user.notify('success',I18n.t(:noti_item_deleted))
			redirect_to items_path
		else
			current_user.notify('warning',I18n.t(:noti_no_permissions))
			redirect_to @item
		end
	end
	
	private
		def item_params
			params.require(:item).permit(:title, :content, :summary, :category_id, :tag_list)
		end
end
