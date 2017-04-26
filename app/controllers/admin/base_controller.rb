class Admin::BaseController < ApplicationController
  before_action :authenticate_admin
  layout "admin/layouts/admin"

  protected

  def authenticate_admin
    redirect_to root_path unless current_user.present? && current_user.admin?
  end
end
