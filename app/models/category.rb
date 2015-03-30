class Category < ActiveRecord::Base
	has_many :items
	validates :name, :summary, presence: true
end
