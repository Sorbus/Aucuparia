class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new # if necessary, create a guest user
		
		can :read, [Category, Item, Comment, User]
		can :see, [:moderator, :editor, :author, :commenter]
		
		if user.id == nil # for guest users
			can :create, User
		else
			# these permissions are given to every user.
			can :see, [:admin]
			can :manage, User, :user_id => user.id
			can :timestamp, User, :user_id => user.id
			can :see_email, User, :user_id => user.id
			# now, let's see what special things we can do ...
			user.roles.each do |role|
				self.send role, user # need to pass the user object along, or things break.
			end
		end
	end
	
	# remember, the set of valid roles is defined in user.rb. Adding new ones here is necessary but not sufficient.
	private
	
	def superadmin(user)
		can :manage, :all
	end
	
	def admin(user)
		can :manage, [Comment, Item, Category, User, StaticPage, Menu]
		can :assign, [:moderator, :editor, :author, :commenter]
		can :see, [:superadmin, :admin_tools]
	end
	
	def moderator(user)
		can :manage, Comment
	end
	
	def editor(user)
		can :manage, Item
	end
	
	def author(user)
		can :manage, Item, :user_id => user.id
	end
	
	def commenter(user)
		can :manage, Comment, :user_id => user.id
	end
end
