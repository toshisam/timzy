class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index
    is_user_team_member?
  end

  def show?
   is_user_team_member?
  end

  def new?
    return true
  end

  def create?
    return true
  end

  # @project  <=> record
  # current_user <=> user
  def update?
    # seul le createur d'un projet ou un admin peut le modifier
    is_user_owner_or_admin?
  end

  def destroy?
    is_user_owner_or_admin?
  end

  def vote?
    show?
  end

  private

  def is_user_team_member?
    record.team.users.include? user
  end

  def is_user_owner_or_admin?
    record.user == user || record.team.admin == user
  end

end
