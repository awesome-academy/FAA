class Education::TrainingsController < Education::BaseController
  before_action :load_training, except: [:new, :index, :create]
  load_and_authorize_resource except: [:index, :show]

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

  def new
    @training = Education::Training.new
  end

  def create
    @training = Education::Training.new training_params
    if @training.save
      technique_service.add
      flash[:success] = t ".training_created"
      redirect_to education_trainings_path
    else
      flash[:danger] = t ".training_create_failed"
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js do
        render partial: "education/trainings/form",
          locals: {training: @training, button_text: t(".update_project")},
          layout: false
      end
    end
  end

  def update
    if @training.update_attributes training_params
      technique_service.update
      flash[:success] = t ".training_updated_successfully"
      redirect_to @training
    else
      render :edit
    end
  end

  def destroy
    if @training.destroy
      @trainings = Education::Training.newest
      respond_to do |format|
        format.html do
          redirect_to education_trainings_path
          flash[:success] = t ".deleted_success"
        end
        format.json{render json: {flash: t(".deleted_success"), status: 200}}
      end
    else
      flash[:danger] = t ".training_delete_fail"
      redirect_to education_trainings_path
    end
  end

  private

  def load_training
    return if @training = Education::Training.find_by(id: params[:id])
    flash[:error] = t "education.trainings.training_not_found"
    redirect_to education_root_path
  end

  def training_params
    params.require(:education_training).permit :name, :description,
      images_attributes: [:id, :url, :url_cache, :_destroy]
  end

  def technique_service
    Education::TrainingTechniqueService.new @training, params
  end
end
