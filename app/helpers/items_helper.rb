module ItemsHelper
  def cache_key_for_items
    count          = Item.count
    max_updated_at = Item.maximum(:updated_at).try(:utc).try(:to_s, :number)
    page           = params[:page]
    "items/all-#{count}-#{max_updated_at}-#{page}"
  end
end
