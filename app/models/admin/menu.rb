class Admin::Menu < ActiveRecord::Base
	has_many :categories
	validates :title, presence: true
end
