class Item < ActiveRecord::Base
	belongs_to :category
	validates :title, :content, :summary, :category, presence: true
	default_scope { order("created_at DESC") }
end
