module TagsHelper
  def cache_key_for_tags
    count          = (ActsAsTaggableOn::Tag.most_used).count
    page           = params[:page]
    "tags/all-#{count}-#{page}"
  end
end
