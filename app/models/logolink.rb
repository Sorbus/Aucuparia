class Logolink < ActiveRecord::Base
	validates :url, :css_id, presence: true
end
