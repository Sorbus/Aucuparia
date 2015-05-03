class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new # if necessary, create a guest user
		
		can :read, [Category, User]
		can :read, [Comment], :deleted => false
		can :read, [Item] do |item|
			user.shares_any_group?(item) || item.groups.first.nil?
			!item.deleted?
			item.published?
		end
		can :see, [:moderator, :editor, :author, :commenter]
		
		if user.id == nil # for guest users
			can :create, User
		else
			# these permissions are given to every user.
			can :see, [:admin]
			can :manage, User, :id => user.id
			can :timestamp, User, :id => user.id
			can :see_email, User, :id => user.id
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
		can :manage, Group
	end
	
	def moderator(user)
		can :manage, Comment, :deleted => false
	end
	
	def editor(user)
		can :manage, Item, :deleted => false
		can :read, Group do |group|
			user.in_group?(group)
		end
	end
	
	def author(user)
		can :manage, Item, :user_id => user.id, :deleted => false
		can :create, Group
		can :manage, Group do |group|
			user.in_group?(group, as: 'manager')
		end
		can :read, Group do |group|
			user.in_group?(group)
		end
	end
	
	def commenter(user)
		can :manage, Comment, :user_id => user.id, :deleted => false
	end
end
