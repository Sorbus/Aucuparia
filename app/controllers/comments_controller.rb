class CommentsController < ApplicationController
	
	def new
		authorize! :create, Comment
		@comment = Comment.new
		@item = Item.find(params[:item_id])
	end
	
	def edit
		@comment = Comment.find(params[:id])
		authorize! :update, @comment
	end
	
	def create
		authorize! :create, Comment
		if params.has_key?(:reply_id) && (@comment = Comment.find(params[:reply_id]).children.create(comment_params))
			@comment.user_id = current_user.id
			@comment.item_id = params[:item_id]
			@comment.save
			# this is hacky and horrible.
			flash[:notice] = "Comment created."
			redirect_to item_path(:id => @comment.item_id)
		else
			@comment = Comment.new(comment_params)
			@comment.user_id = current_user.id
			@comment.item_id = params[:item_id]
			if params[:commit] == 'commit' && @comment.save
				flash[:notice] = "Comment created."
				redirect_to item_path(:id => @comment.item_id)
			else
				flash[:alert] = "Comment not saved!"
				redirect_to item_path(:id => @comment.item_id)
			end
		end
	end
	
	def update
		@comment = Comment.find(params[:id])
		authorize! :update, @comment
		if params[:commit] == 'commit' && @comment.update(comment_params)
				flash[:notice] = "Comment updated."
				redirect_to item_path(:id => @comment.item_id)
			else
				flash[:alert] = "Comment not saved!"
				redirect_to item_path(:id => @comment.item_id)
			end
	end
	
	def destroy
		@comment = Comment.find(params[:id])
		if can? :destroy, @comment
			begin
				@comment.destroy
			rescue Ancestry::AncestryException
				@comment.update({:user_id => nil})
			end
			redirect_to item_path(params[:item_id])
		else
			redirect_to item_path(@comment.item)
		end
	end
	
	private
		def comment_params
			params.require(:comment).permit(:body)
		end
end
