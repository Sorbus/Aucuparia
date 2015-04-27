class MessagesController < ApplicationController

#<% noti.mark_as_read(current_user) %>

	def destroy
		@noti = current_user.mailbox.notifications.find_by_id(params[:id])
		if !@noti.nil?
			@noti.mark_as_read
		end
		redirect_to root_path
	end
	
	def index
		respond_to do |format|
			format.js
			format.html { redirect_to root_path }
		end
	end
end
