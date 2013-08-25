class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= Registration.new # guest user (not logged in)

      case user.registrateable_type
        when 'Fan'
          can :manage, Fan
        when 'Band'
          can [:edit, :update], Band
          can :edit_media, Band do |band|
            !band.registration.pending? || band.registration.current_step == 'edit_media'
          end
        when 'Venue'
          can [:edit, :update], Venue
          can :edit_media, Venue do |venue|
            !venue..registration.pending? || venue.registration.current_step == 'edit_media'
          end
          can :edit_schedule, Venue do |venue|
            !venue.registration.pending? || venue.registration.current_step == 'edit_schedule'
          end
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
