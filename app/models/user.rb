class User < ActiveRecord::Base
	acts_as_authentic
	has_many :items
	has_many :comments
	has_one :registration_token
	validates :password, presence: true, on: :create
	validates :email, :display_name, presence: true
	validates :email, :display_name, uniqueness: true
	validates :email, email: true
	validates :website, :url => {:allow_blank => true}
end
