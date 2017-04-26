class Education::HomeController < Education::BaseController
  layout "education/layouts/application"

  def index
    @home_object = Supports::Education::Home.new
  end
end
