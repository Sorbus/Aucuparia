class WelcomeController < ApplicationController
	def index
		@page = StaticPage.first
	end
	
	def about
		@page = StaticPage.second
	end
end