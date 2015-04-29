class WelcomeController < ApplicationController
	def index
		@page = StaticPage.first
		@links = Logolink.all
		@recent = Item.order('created_at DESC').where(:published => true, :deleted => false).limit(3)
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def about
		@page = StaticPage.second
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def fetch
		if params[:node] == '1'
			@selected = Item.order('created_at DESC').where(:published => true, :deleted => false).limit(3)
			respond_to do |format|
				format.js { render :action => "fetch_recent" }
				format.html { redirect_to(items_path) }
			end
		elsif params[:node] == '2'
			@categories = Category.all
			respond_to do |format|
				format.js { render :action => "fetch_categories" }
				format.html { redirect_to(categories_path) }
			end
		elsif params[:node] == '3'
			@tags = ActsAsTaggableOn::Tag.most_used(10)
			respond_to do |format|
				format.js { render :action => "fetch_tags" }
				format.html { redirect_to(tags_path) }
			end
		else
			
		end
	end
end