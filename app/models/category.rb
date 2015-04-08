class Category < ActiveRecord::Base
	has_many :items
	belongs_to :menus
	validates :name, :summary, presence: true
end
