class ItemsController < ApplicationController
	load_and_authorize_resource
#	before_action :require_user, except: [:index, :show]

	def index 
		@posts = Item.paginate(:page => params[:page], :per_page => 5)
	end
	
	def show
		@item = Item.find(params[:id])
	end
	
	def new
		@item = Item.new
		@cat_options = Category.all.map{|c| [ c.name, c.id ] }
	end

	def edit
		@item = Item.find(params[:id])
		@cat_options = Category.all.map{|c| [ c.name, c.id ] }
	end
 
	def create
		@item = Item.new(item_params)
		@item.category = Category.find(params[:item][:category_id])
		@item.user = User.find(current_user.id)
#		render plain: params[:item].inspect
		
		if params[:commit] == 'commit' && @item.save
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
				redirect_to @item
			else
				@item = Item.new(item_params)
				@cat_options = Category.all.map{|c| [ c.name, c.id ] }
				render 'edit'
			end
		else
			redirect_to @item
		end
	end
	
	def destroy
		@item = Item.find(params[:id])
		if can? :destroy, @item
			@item.destroy
			redirect_to login_path
		else
			redirect_to @item
		end
	end
	
	private
		def figure_it_out
			if params[:commit] == 'commit'
				if @item.save
					redirect_to @item
				else
					render 'new'
				end
			else
				@cat_options = Category.all.map{|c| [ c.name, c.id ] }
				render 'preview'
			end
		end
	
		def item_params
			params.require(:item).permit(:title, :content, :summary, :category_id)
		end
end
