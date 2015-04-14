class Users::RegistrationsController < Devise::RegistrationsController
	before_filter :check_permissions, :only => [:new, :create, :cancel]
	skip_before_filter :require_no_authentication
	before_filter :configure_permitted_parameters, :only => [:create]
 
	def check_permissions
		authorize! :create, User
	end
	
	protected
		def configure_permitted_parameters
		  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:display_name, :email, :password) }
		end
end