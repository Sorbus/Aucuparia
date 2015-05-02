class User < ActiveRecord::Base
	# hooks
	before_create :set_defaults
	before_destroy :clean_up_possessions
	before_save :set_roles
	
	# setup roles using RoleModel
	include RoleModel
	roles_attribute :roles_mask
	# this is the master list of all accessible roles
	roles :superadmin, :admin, :moderator, :editor, :author, :commenter
	
	# mailboxer
	acts_as_messageable
	
	# mount uploader to manage avatars
	mount_uploader :avatar, AvatarUploader
	
	# devise
	devise :database_authenticatable, :registerable, :lockable,
		:recoverable, :rememberable, :trackable, :validatable,
		:omniauthable, :omniauth_providers => [:twitter]
		
	# relationships
	has_many :items
	has_many :comments
	
	# group stuff
	groupify :group_member
	groupify :named_group_member

	# validation
	validates :password, presence: true, on: :create
	validates :email, :display_name, presence: true, on: create
	validates :email, :display_name, uniqueness: true
#	validates :email, email: true, if !self.provider.nil?
	validates :website, :url => {:allow_blank => true}
	
	# omniauth login & registration
	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.email = auth.info.email
			user.website = auth.info.urls.Twitter
			user.biography = auth.info.description
			user.password = Devise.friendly_token[0,20]
			user.display_name = auth.info.name
			user.roles << :commenter
		end
	end
	
	# check if the user has a role
	def role?(role)
		return !!self.roles.find_by_name(role.to_s.camelize)
	end
 
	def get_user
		@current_user = current_user
	end
	
	def mailboxer_email(object)
		return self.email
	end
	
	private
	
	def email_required?
      true unless !self.provider.nil?
    end
	
	# Gives all users the default role of commenter and puts them in the registered users group
	def set_defaults
		self.roles << :commenter
		self.groups << Group.first
	end
	
	# Before a user is destroyed, clean up all of their items and comments.
	def clean_up_possessions
		# Consider changing this to just remove user ids? Or that alongside tagging them as deleted and hiding them from most users.
		self.items.each do |item|
			item.destroy
		end
		self.comments.each do |comment|
			comment.destroy
		end
	end
end
