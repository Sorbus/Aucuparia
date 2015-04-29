class CommentsController < ApplicationController
	
	def new
		authorize! :create, Comment
		@comment = Comment.new
		@item = Item.where(:published => true, :deleted => false).find(params[:item_id])
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def edit
		@comment = Comment.find(params[:id])
		authorize! :update, @comment
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def create
		authorize! :create, Comment
		if params.has_key?(:reply_id) && (@comment = Comment.where(:deleted => false).find(params[:reply_id]).children.create(comment_params))
			@comment.user_id = current_user.id
			@comment.item_id = params[:item_id]
			@comment.save # this is hacky and horrible.
			flash[:success] = I18n.t(:noti_comment_created)
			tell_parent(@comment)
			tell_author(@comment)
			respond_to do |format|
				format.js { render 'insert_single' }
				format.html { redirect_to item_path(:id => @comment.item_id) }
			end
		else
			@comment = Comment.new(comment_params)
			@comment.user_id = current_user.id
			@comment.item_id = params[:item_id]
			if params[:commit] == 'commit' && @comment.save
				flash[:success] = I18n.t(:noti_comment_created)
				tell_author(@comment)
				respond_to do |format|
					format.js { render 'insert_single' }
					format.html { redirect_to item_path(:id => @comment.item_id) }
				end
			else
				flash[:error] = I18n.t(:noti_comment_failed)
				redirect_to item_path(:id => @comment.item_id)
			end
		end
	end
	
	def update
		@comment = Comment.find(params[:id])
		authorize! :update, @comment
		if params[:commit] == 'commit' && @comment.update(comment_params)
				flash[:success] = I18n.t(:noti_comment_updated)
				respond_to do |format|
					format.js
					format.html { redirect_to item_path(:id => @comment.item_id) }
				end
			else
				flash[:error] = I18n.t(:noti_comment_failed)
				respond_to do |format|
					format.js
					format.html { redirect_to item_path(:id => @comment.item_id) }
				end
			end
	end
	
	def destroy
		@comment = Comment.find(params[:id])
		if can? :destroy, @comment
			@comment.update(:deleted => true)
			flash[:success] = I18n.t(:noti_comment_deleted)
			redirect_to item_path(params[:item_id])
		else
			flash[:error] = I18n.t(:noti_no_permissions)
			redirect_to item_path(@comment.item)
		end
	end
	
	private
		def comment_params
			params.require(:comment).permit(:body)
		end
		
		def tell_author(comment)
			#comment.item.user.notify('info', ('New comment on your post "<a href="' + app.item_path(comment.item.id) + '">' + comment.item.title + '</a>"'))
		end
		
		def tell_parent(comment)
			#comment.parent.user.notify('info', (New reply to your comment on "<a href="' + app.item_path(comment.item.id) + '">' + comment.item.title + '</a>"'))
		end
end
