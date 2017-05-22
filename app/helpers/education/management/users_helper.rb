module Education::Management::UsersHelper
  def role_select
    User.roles.select{|role| role != Settings.user_role.super_admin}
      .map{|role, index| [role.camelize, role]}
  end
end
