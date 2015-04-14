class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	
	helper_method :current_user_session, :current_user
	
	rescue_from CanCan::AccessDenied do |exception|
		flash[:error] = exception.message
		redirect_to root_path
	end
end
