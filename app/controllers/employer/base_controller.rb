class Employer::BaseController < ApplicationController
  layout "employer/layouts/application"
  load_resource :company
  before_action :require_employer

  private

  def require_employer
    authorize! :update, @company
  end
end
