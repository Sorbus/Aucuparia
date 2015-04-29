class TagsController < ApplicationController
	def index
		@tags = (ActsAsTaggableOn::Tag.most_used).paginate(:page => params[:page], :per_page => 20)
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def show
		@items = Item.where(:deleted => false, :published => true).tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
		respond_to do |format|
			format.js
			format.html
		end
	end
end
