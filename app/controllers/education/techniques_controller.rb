class Education::TechniquesController < Education::BaseController
  def index
    @techniques = Education::Technique.newest
      .includes(:image, :translations).page(params[:page])
      .per Settings.education.technique.per_page
  end
end
