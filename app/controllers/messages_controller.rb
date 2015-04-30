class MessagesController < ApplicationController
	before_filter :authenticate_user!, :except => [:refresh]

	# to send messages:
	# user.notify(subject, body, obj = nil, sanitize_text = true, notification_code = nil, send_mail = true)
	# see http://www.rubydoc.info/gems/mailboxer/Mailboxer/Models/Messageable#notify-instance_method

	def destroy
		@noti = current_user.mailbox.notifications.find_by_id(params[:id])
		if !@noti.nil?
			@noti.mark_as_read(current_user)
			respond_to do |format|
				format.js
				format.html { redirect_to root_path }
			end
		else
			respond_to do |format|
				format.js
				format.html { redirect_to root_path }
			end
		end
		
	end
	
	def index
		@notifications = current_user.mailbox.notifications.unread
		respond_to do |format|
				format.js
				format.html
			end
	end
	
	def refresh
		respond_to do |format|
			format.js
			format.html { redirect_to root_path }
		end
	end
end
