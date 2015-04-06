class WelcomeController < ApplicationController
	def index
		@page = Website.first
	end
	
	def about
		@page = Website.second
	end
end