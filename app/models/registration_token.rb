class RegistrationToken < ActiveRecord::Base
	has_one :user
	validates :token, :access_tier, presence: true
	validates :access_tier, length: { minimum: 1, maximum: 7 }
	validates :token, uniqueness: true
end
