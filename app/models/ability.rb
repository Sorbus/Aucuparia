class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new # if necessary, create a guest user
		
		if user.roles.size == 0 # for guest users with no permissions
			can :read, [Category, Item, Comment, User]
			can :see, [:moderator, :editor, :author, :commenter]
			can :create, User
		else
			# these permissions are given to every user.
			can :manage, User, :user_id => user.id
			can :timestamp, User, :user_id => user.id
			can :see_email, User, :user_id => user.id
			can :see, [:admin, :moderator, :editor, :author, :commenter]
			# now, let's see what special things we can do ...
			user.roles.each { |role| send(role) }
		end
	end
	
	# remember, the set of valid roles is defined in user.rb. Adding new ones here is necessary but not sufficient.
	def superadmin
		can :manage, :all
	end
	
	def admin
		can :manage, [Comment, Item, Category, User, StaticPage, Menu]
		can :assign, [:moderator, :editor, :author, :commenter]
		can :see, :superadmin
	end
	
	def moderator
		can :manage, Comment
	end
	
	def editor
		can :manage, Item
	end
	
	def author
		can :manage, Item, :user_id => user.id
	end
	
	def commenter
		can :manage, Comment, :user_id => user.id
	end
end
