class Education::Management::BaseController < ApplicationController
  layout "education/layouts/application_management"
  before_action :authorize_admin

  def render_json message, status_code
    respond_to do |format|
      format.json{render json: {flash: message, status: status_code}}
    end
  end

  private

  def authorize_admin
    unless current_user && current_user.role?(:admin)
      flash[:danger] = t "education.management.user_permission"
      redirect_to education_root_path
    end
  end
end
