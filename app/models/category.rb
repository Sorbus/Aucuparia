class Category < ActiveRecord::Base
	has_many :items
	belongs_to :website
	validates :name, :summary, presence: true
end
