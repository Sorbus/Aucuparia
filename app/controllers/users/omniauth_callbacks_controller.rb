class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def twitter
		@user = User.from_omniauth(request.env['omniauth.auth'])
		
		# This code is really ugly, but it works.
		# Somehow.
		# I don't understand why
		# 
		# If the user already exists, the first sign_in works.
		# But if the user didn't exist until User.from_omniauth was called, it fails.
		# But then the second sign_in works.
		# But if we don't sign out the user first, it doesn't work!
		#
		# My beautiful logical codebase is ruined forever.
		
		sign_in @user
		sign_out @user
		sign_in_and_redirect @user
	end
end