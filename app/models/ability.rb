class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new # if necessary, create a guest user?
		if user.admin?
			can :manage, :all
		else
			if user.access_tier == 7
				can :manage, :all
			elsif user.access_tier == 5 
				can :manage, [Article, Comment], :user_id => user.id
				can :destroy, Comment
				can :update, Category
				can :read, :all
				can :update, User, :user_id => user.id
			elsif user.access_tier == 3
				can :manage, [Article, Comment], :user_id => user.id
				can :read, :all
				can :update, User, :user_id => user.id
			elsif user.access_tier == 1
				can :manage, Comment, :user_id => user.id
				can :read, :all
				can :update, User, :user_id => user.id
			else # guest user
				can :read, :all
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
