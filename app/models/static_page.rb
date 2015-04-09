class StaticPage < ActiveRecord::Base
	has_many :categories
	validates :title, :content, :menu_title, presence: true
end
