class Ability
  include CanCan::Ability

  def can_take_step step, registrateable_class
    can step.to_sym, registrateable_class do |obj|
      (!obj.registration.pending? || obj.registration.current_step == step) &&
      obj.id == @user.registrateable_id
    end
  end

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      @user = user || Registration.new # guest user (not logged in)
      registrateable = @user.registrateable

      if @user.persisted?
        can :logout, Registration
      else
        can [:login_form, :login, :new, :create], Registration
      end

      case registrateable
        when Fan
          can :manage, Fan, id: registrateable.id
        when Band
          can [:edit, :update], Band, id: registrateable.id
          can_take_step 'edit_media', Band
        when Venue
          can [:edit, :update], Venue#, id: registrateable.id
          can_take_step 'edit_media', Venue
          can_take_step 'add_show', Venue
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
