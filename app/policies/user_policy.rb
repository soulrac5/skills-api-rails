class UserPolicy < ApplicationPolicy
  #Authorization user CRUDS
  def create?
    @user.try(:rol_id) == 1
  end
  def update?
    @user.try(:rol_id) == 1
  end
  def destroy?
    @user.try(:rol_id) == 1
  end
  def tags?
    @user.try(:rol_id) == 1 || @user.try(:rol_id) == 3
  end
end
