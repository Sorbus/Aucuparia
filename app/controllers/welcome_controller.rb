class WelcomeController < ApplicationController
	def index
		@page = StaticPage.first
		@links = Logolink.all
	end
	
	def about
		@page = StaticPage.second
	end
end