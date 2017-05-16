class Ability
  include CanCan::Ability

  ROLES = %w(admin trainer)

  def initialize user
    user ||= User.new
    can :manage, :all if user.role?(:admin)
    can :manage, Education::Post if user.role?(:trainer)
    can :read, :all if user.role?(:user)
  end
end
