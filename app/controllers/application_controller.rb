class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	
	helper_method :current_user_session, :current_user
	
	rescue_from CanCan::AccessDenied do |exception|
		flash[:error] = exception.message
		redirect_to root_path
	end
	
	rescue_from ActiveRecord::RecordNotFound do |exception|
		flash[:error] = exception.message
		# flash[:error] = I18n.t(:noti_generic_failure)
		redirect_to root_path
	end
	
	unless Rails.application.config.consider_all_requests_local
		#rescue_from Exception, :with => :render_error
		rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found   
		rescue_from ActionController::RoutingError, :with => :render_not_found
	end 
	
	#called by last route matching unmatched routes.  Raises RoutingError which will be rescued from in the same way as other exceptions.
	def raise_not_found!
		raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
	end

	#render 500 error 
	def render_error(e)
		puts e.message
		#puts e.backtrace.join("\n")
		respond_to do |f| 
			f.html{ render :template => "errors/error_500", :status => 500 }
			f.js{ render :partial => "errors/error_500", :status => 500 }
		end
	end

	#render 404 error 
	def render_not_found(e)
		puts e
		respond_to do |f| 
			f.html{ render :template => "errors/error_404", :status => 404 }
			f.js{ render :partial => "errors/error_404", :status => 404 }
		end
	end
end
