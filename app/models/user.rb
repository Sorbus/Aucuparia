class User < ActiveRecord::Base
	acts_as_authentic
	has_many :items
	validates :password, presence: true, on: :create
	validates :email, :display_name, presence: true
	validates :email, :display_name, uniqueness: true
end
