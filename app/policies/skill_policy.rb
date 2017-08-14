class SkillPolicy < ApplicationPolicy
  def create?
    @user.rol_id == 1
  end
  def update?
    @user.rol_id == 1
  end
  def destroy?
    @user.rol_id == 1
  end
end
