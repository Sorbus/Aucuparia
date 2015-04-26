class User < ActiveRecord::Base
	# setup roles using RoleModel
	include RoleModel
	roles_attribute :roles_mask
	# this is the master list of all accessible roles
	roles :superadmin, :admin, :moderator, :editor, :author, :commenter
	
	# mount uploader to manage avatars
	mount_uploader :avatar, AvatarUploader
	
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :lockable,
		:recoverable, :rememberable, :trackable, :validatable,
		:omniauthable, :omniauth_providers => [:twitter]
	has_many :items
	has_many :comments
	# has_one :registration_token
	validates :password, presence: true, on: :create
	validates :email, :display_name, presence: true
	validates :email, :display_name, uniqueness: true
	validates :email, email: true
	validates :website, :url => {:allow_blank => true}
	
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
	
	def role?(role)
		return !!self.roles.find_by_name(role.to_s.camelize)
	end
 
	def get_user
		@current_user = current_user
	end
end
