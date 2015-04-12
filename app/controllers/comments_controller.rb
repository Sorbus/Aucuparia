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
		if params.has_key?(:reply_id)
			if Comment.find(params[:reply_id]).children.create(comment_params)
				
			else  	
			end
		else
			@comment = Comment.new(comment_params, item_id: params[:item_id], user_id: current_user.id)
			@comment.item_id = params[:item_id]
			@comment.user_id = current_user.id
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
