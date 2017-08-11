class SkillsUserPolicy < ApplicationPolicy
  def create?
    @user.rol_id == 1 || @user.rol_id == 2
  end
end
