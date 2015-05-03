class Item < ActiveRecord::Base
	groupify :group_member
	acts_as_taggable
	belongs_to :category
	belongs_to :user
	has_many :comments
	validates :title, :content, :summary, :category, :user, presence: true
	default_scope { order("created_at DESC") }
	paginates_per 2
end
