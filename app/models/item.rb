class Item < ActiveRecord::Base
	belongs_to :category
	belongs_to :user
	has_many :comments
	validates :title, :content, :summary, :category, :user, presence: true
	default_scope { order("created_at DESC") }
end
