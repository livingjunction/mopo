class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    if user.teacher?
      cannot :manage, Category
      can :read, Category
      can :manage, [Assignment, Project, Scrap, Asset, Link, Comment, User, Flag]
      can :manage, Like, :user_id => user.id
      can :manage, Notification, :user_id => user.id

    elsif user.student?
      can :read, Category
      can :read, Assignment

      can :read, Project
      can :manage, Project, :user_id => user.id

      can :read, Scrap, :privacy => :public
      can :read, Scrap, :privacy => :registered
      can :manage, Scrap, :user_id => user.id

      can :read, Asset
      can :manage, Asset, :user_id => user.id

      can :read, Link
      can :manage, Link, :user_id => user.id

      can :read, Comment
      can :manage, Comment, :user_id => user.id

      can :read, User
      can :manage, User, :id => user.id

      can :manage, Like, :user_id => user.id
      can :manage, Notification, :user_id => user.id

      can :read, Flag
    else
      can :read, [Category, Assignment, Project, Asset, Link, Comment, User, Like, Flag]
      can :read, Scrap, :privacy => :public
      can :create, User
    end
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
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
