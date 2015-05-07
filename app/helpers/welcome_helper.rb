module WelcomeHelper
	def cache_key_for_recent_items
    count          = Item.count
		max_updated_at = Item.where(:deleted => false, :published => true).maximum(:updated_at).try(:utc).try(:to_s, :number)
		"items/recent-#{count}-#{max_updated_at}"
	end
	
	def cache_key_for_categories
		max_updated_at = Category.maximum(:updated_at).try(:utc).try(:to_s, :number)
		"categories/all-#{max_updated_at}"
	end
end
