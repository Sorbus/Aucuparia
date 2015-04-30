class ItemsController < ApplicationController
	load_and_authorize_resource
	before_filter :authenticate_user!, :except => [:index, :show]

	def index 
		@posts = Item.where(:published => true, :deleted => false).paginate(:page => params[:page], :per_page => 5)
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def show
		@item = Item.find(params[:id])
		@comment = Comment.new
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
		@item = Item.new(create_item_params)
		@item.category = Category.find(params[:item][:category_id])
		@item.user = User.find(current_user.id)
		if params[:commit] == 'commit' && @item.save
			flash[:success] = I18n.t(:noti_item_created)
			redirect_to @item
		else
			@cat_options = Category.all.map{|c| [ c.name, c.id ] }
			render 'new'
		end
	end
	
	def update
		@item = Item.find(params[:id])
		@item.category = Category.find(params[:item][:category_id])
		if (params[:commit] == 'commit') && @item.update(update_item_params)
			flash[:success] = I18n.t(:noti_item_updated)
			redirect_to @item
		else
			@item = Item.new(update_item_params)
			@cat_options = Category.all.map{|c| [ c.name, c.id ] }
			render 'edit'
		end
	end
	
	def publish
		@item = Item.find(params[:item_id])
		if !item.published
			item.update(:published => true)
		elsif can? :retract, item
			item.update(:published => false)
		end
		redirect_to @item
	end
	
	def destroy
		@item = Item.find(params[:id])
		@item.update(:deleted => true)
		flash[:success] = I18n.t(:noti_item_deleted)
		redirect_to items_path
	end
	
	private
		def create_item_params
			params.require(:item).permit(:title, :content, :summary, :category_id, :tag_list, :published)
		end
		
		def update_item_params
			params.require(:item).permit(:title, :content, :summary, :category_id, :tag_list)
		end
end
