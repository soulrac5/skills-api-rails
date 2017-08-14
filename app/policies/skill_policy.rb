class SkillPolicy < ApplicationPolicy
  def create?
    @user.try(:rol_id) == 1
  end
  def update?
    @user.try(:rol_id) == 1
  end
  def destroy?
    @user.try(:rol_id) == 1
  end
end
