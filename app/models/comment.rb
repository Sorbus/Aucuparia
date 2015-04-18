class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :item
	has_ancestry :orphan_strategy => :restrict
	validates :body, :item, presence: true
end
