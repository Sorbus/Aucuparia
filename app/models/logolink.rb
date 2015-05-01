class Logolink < ActiveRecord::Base
	validates :url, presence: true
end
