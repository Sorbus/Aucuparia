class Item < ActiveRecord::Base
	belongs_to :category
	belongs_to :user
	validates :title, :content, :summary, :category, presence: true
	default_scope { order("created_at DESC") }
end
