module Education::Management::UsersHelper
  def role_select
    User.roles.reject{|role| role == Settings.user_role.super_admin}
      .map{|role, _index| [role.camelize, role]}
  end
end
