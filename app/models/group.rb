class Group < ActiveRecord::Base
	groupify :group, members: [:users, :items], default_members: :users
	validates :title, presence: true
end
