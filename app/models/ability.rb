class Ability
  include CanCan::Ability

  def can_take_step step, registrateable_class
    can step.to_sym, registrateable_class do |obj|
      (!obj.registration.pending? || obj.registration.current_step == step) &&
      obj.id == @user.registrateable_id
    end
  end

  def initialize(user)
    @user = user || Registration.new
    registrateable = @user.registrateable

    can [:read], Show
    can [:find, :read], Venue
    can [:find, :read], Band

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
        can [:edit, :update], Venue, id: registrateable.id
        can_take_step 'edit_media', Venue
        can_take_step 'add_show', Venue
    end

    if @user.is?('Venue') || @user.is?('Band')
      can [:new, :create], Show, id: @user.id
      can :manage, Show, venue_id: registrateable.id
      can :manage, Show, band_id: registrateable.id
    end

    can :skip, Registration

  end
end
