class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new # if necessary, create a guest user
		user.registration_token ||= RegistrationToken.new
		if user.registration_token.is_superuser?
			can :manage, :all
		else
			can :manage, User, :user_id => user.id
			if user.registration_token.can_comment?
				can :manage, Comment, :user_id => user.id
			end
			if user.registration_token.can_author?
				can :manage, Article, :user_id => user.id
			end
			if user.registration_token.is_moderator?
				can :destroy, Comment
				can :update, Comment
			end
			if user.registration_token.is_editor?
				can :destroy, Article
				can :update, Article
			end
			if user.registration_token.is_administrator?
				can :update, Website
				can :manage, User
				can :create, RegistrationToken
				can :update, RegistrationToken
				can :destroy, RegistrationToken
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
