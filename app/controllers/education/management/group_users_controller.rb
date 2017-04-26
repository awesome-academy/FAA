class Education::Management::GroupUsersController <
  Education::Management::BaseController
  load_and_authorize_resource class: Education::UserGroup

  def index
    @groups = Education::Group.includes :users
    @group_user_object = Supports::Education::Management::ShowGroupUsers
      .new params
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    group = Education::Group.find_by id: users_params[:group.to_s]
    failure_respond t(".group_not_found") unless group
    users_params[:users.to_s].each do |user|
      user = User.find_by(id: user[:id.to_s])
      unless user
        failure_respond t(".user_not_found")
        break
      end
      education_group = user.education_user_groups.first_or_create
      unless education_group.update_attributes group: group
        failure_respond t(".add_failed")
        break
      end
    end
    success_respond t(".add_success"), group
  end

  def destroy
    group = Education::Group.find_by id: users_params[:group.to_s]
    failure_respond t(".group_not_found") unless group
    users_params[:users.to_s].each do |user|
      user = User.find_by(id: user[:id.to_s])
      unless user
        failure_respond t(".user_not_found")
        break
      end
      unless user.education_user_groups.first.destroy
        failure_respond t(".remove_failed")
        break
      end
    end
    success_respond t(".remove_success"), group
  end

  private

  def users_params
    JSON.parse params.require(:education_management_users)
  end

  def failure_respond message
    flash[:danger] = message
    @group_id = users_params[:group.to_s]
    respond_to do |format|
      format.js
    end
  end

  def success_respond message, group
    @group_object = group
    flash[:success] = message
    respond_to do |format|
      format.js
    end
  end
end
