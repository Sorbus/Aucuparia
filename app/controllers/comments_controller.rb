class CommentsController < ApplicationController
	
	def new
		authorize! :create, Comment
	end
	
	def edit
		@comment = Comment.find(params[:id])
		authorize! :update, @comment
	end
	
	def create
		authorize! :create, Comment
		@comment = Comment.new(comment_params)
		@comment.item_id = params[:item_id]
		@comment.user_id = current_user.id
		if params[:commit] == 'commit' && @comment.save
			redirect_to item_path(@comment.item)
		else
			render 'new'
		end
	end
	
	def update
		@comment = Comment.find(params[:id])
		authorize! :update, @comment
	end
	
	def destroy
		@comment = Comment.find(params[:id])
		if can? :destroy, @comment
			@comment.destroy
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
