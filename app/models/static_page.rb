class StaticPage < ActiveRecord::Base
	has_many :categories
	validates :title, :content, presence: true
end
