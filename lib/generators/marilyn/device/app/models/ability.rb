class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= User.new # guest user

    if current_user.admin?
      can :manage, :all
    else
      can [:show, :update, :change_password, :edit_social_accounts], User do |user|
        user == current_user
      end

      can :deactivate, Authentication do |auth|
        auth.user == current_user
      end

      can :read, :all
    end
  end

end