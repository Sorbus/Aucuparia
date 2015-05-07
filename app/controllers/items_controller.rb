class ItemsController < ApplicationController
	load_and_authorize_resource

	def index 
		@posts = Item.where(:published => true, :deleted => false).page(params[:page])
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def show
		@comment = Comment.new
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def new
		@cat_options = Category.all.map{|c| [ c.name, c.id ] }
		respond_to do |format|
			format.js
			format.html
		end
	end

	def edit
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
		if !@item.published
			@item.update(:published => true)
		elsif can? :retract, @item
			@item.update(:published => false)
		end
		redirect_to @item
	end
	
	def destroy
    if @item.update(:deleted => true)
      flash[:success] = I18n.t(:noti_item_deleted)
      redirect_to items_path
    else
      flash[:error] = I18n.t(:noti_deletion_failed)
      redirect_to @item
    end
	end
	
	private
		def verify_group
			redirect_to new_user_session_path unless test_group?(@item)
		end
		
		def test_group?(item)
			(item.groups.first.nil? || (!current_user.nil? && (current_user.id == item.user_id || current_user.shares_any_group?(item))))
		end
		
		def create_item_params
			params.require(:item).permit(:title, :content, :summary, :category_id, :tag_list, :published)
		end
		
		def update_item_params
			params.require(:item).permit(:title, :content, :summary, :category_id, :tag_list)
		end
		
		
end
