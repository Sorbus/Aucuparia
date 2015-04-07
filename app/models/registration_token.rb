class RegistrationToken < ActiveRecord::Base
	belongs_to :user
	validates :token, presence: true
	validates :token, uniqueness: true
end
