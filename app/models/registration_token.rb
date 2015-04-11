class RegistrationToken < ActiveRecord::Base
	belongs_to :user
	validates :token, presence: true
	validates :token, uniqueness: true
	default_scope { order("created_at DESC") }
end
