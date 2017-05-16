class Education::TrainingsController < Education::BaseController
  before_action :load_training, only: :show

  def index
    param_training = params[:training_search]
    param_technique_name = params[:technique_name]
    param_page = params[:page]

    @training_object = Supports::Education::Training.new param_training,
      param_technique_name, param_page

    respond_to do |format|
      format.html{request.referer}
      format.js
    end
  end

  def show
    @courses = @training.courses
      .limit Settings.education.trainings.courses_limit
  end

  private

  def load_training
    return if @training = Education::Training.find_by(id: params[:id])
    flash[:error] = t "education.trainings.training_not_found"
    redirect_to education_root_path
  end

  def technique_service
    Education::TrainingTechniqueService.new @training, params
  end
end
