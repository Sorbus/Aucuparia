class User < ActiveRecord::Base
	acts_as_authentic
	validates :email, :password, presence: true
	validates :email, uniqueness: true
end
