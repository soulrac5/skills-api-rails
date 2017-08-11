class UserPolicy < ApplicationPolicy
  #Authorization user CRUDS
  def create?
    @user.rol_id == 1
  end
  def update?
    @user.rol_id == 1
  end
  #skills_users
  def update_skills?
    @user.rol_id == 1
  end
  def destroy?
    @user.rol_id == 1
  end
  def tags?
    @user.rol_id == 1 || @user.rol_id == 3
  end
end
