class Education::BaseController < ApplicationController
  layout "education/layouts/application"
  before_action :user_blocked?

  private

  def pagination_by_permission class_name, normal_setting, trainer_setting
    if current_user && manage?(class_name)
      trainer_setting
    else
      normal_setting
    end
  end

  def manage? object
    can?(:create, object) && can?(:update, object) && can?(:destroy, object)
  end

  def user_blocked?
    if current_user.present? && current_user.education_status_blocked?
      sign_out current_user
      flash[:danger] = t "education.base.user_blocked"
      redirect_to root_path
    end
  end
end
