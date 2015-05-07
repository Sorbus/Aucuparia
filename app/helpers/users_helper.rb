module UsersHelper
  def cache_key_for_users
    count          = User.count
    max_updated_at = User.maximum(:updated_at).try(:utc).try(:to_s, :number)
    page           = params[:page]
    "users/all-#{count}-#{max_updated_at}-#{page}"
  end
end
