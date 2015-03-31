class User < ActiveRecord::Base
	acts_as_authentic
	validates :email, :password, :display_name, presence: true
	validates :email, :display_name, uniqueness: true
end
