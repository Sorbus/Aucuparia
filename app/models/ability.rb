class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new # if necessary, create a guest user
		
		if user.roles.size == 0 # for guest users with no permissions
			can :read, [Category, Item, Comment, User]
		else
			can :manage, User, :user_id => user.id
			can :timestamp, User, :user_id => user.id
			can :see_email, User, :user_id => user.id

			if user.has_role? :superadmin
				can :manage, :all
			else
				if user.has_role? :admin
					can :manage, [Comment, Item, Category, User, StaticPage, Menu]
				end
				if user.has_role? :moderator
					can :manage, Comment
				end
				if user.has_role? :editor
					can :manage, Item
				end
				if user.has_role? :author
					can :manage, Item, :user_id => user.id
				end
				if user.has_role? :commenter
					can :manage, Comment, :user_id => user.id
				end
			end
		end
		
		# Define abilities for the passed in user here. For example:
		#
		#	 user ||= User.new # guest user (not logged in)
		#	 if user.admin?
		#		 can :manage, :all
		#	 else
		#		 can :read, :all
		#	 end
		#
		# The first argument to `can` is the action you are giving the user
		# permission to do.
		# If you pass :manage it will apply to every action. Other common actions
		# here are :read, :create, :update and :destroy.
		#
		# The second argument is the resource the user can perform the action on.
		# If you pass :all it will apply to every resource. Otherwise pass a Ruby
		# class of the resource.
		#
		# The third argument is an optional hash of conditions to further filter the
		# objects.
		# For example, here the user can only update published articles.
		#
		#	 can :update, Article, :published => true
		#
		# See the wiki for details:
		# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
	end
end
