class WelcomeController < ApplicationController
	def index
		@page = Core.first
	end
	
	def about
		@page = Core.second
	end
end