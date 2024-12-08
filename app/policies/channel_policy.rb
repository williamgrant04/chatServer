class ChannelPolicy < ApplicationPolicy
  def index?
    # This uses server_users not the channel because the channel doesn't have a user,
    # but we want only server members to be able to access the channel
    if record.nil?
      false
    else
      record.user == user
    end
  end

  def show?
    if record.nil?
      false
    else
      record.user == user
    end
  end

  def create?
    # Only server owner can create a channel, this may change if I decide to expand this to include permissions
    # I should implement a check to see if the user is a member of the server, but that isn't needed right now because the server owner is automatically a member
    record.server.owner == user
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
