class Education::Management::BaseController < ApplicationController
  layout "education/layouts/application_management"

  def render_json message, status_code
    respond_to do |format|
      format.json{render json: {flash: message, status: status_code}}
    end
  end
end
