class Education::ProjectsController < Education::BaseController
  skip_before_action :verify_authenticity_token
  before_action :load_project, except: [:new, :index, :create]
  load_and_authorize_resource except: [:index, :show]

  def index
    load_project_by_name
    load_projects_by_technique
    show_all_project

    @techniques = Education::Technique.with_deleted.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    comments = @project.comments.newest.includes(:user, :commentable)
      .page(params[:page]).per Settings.education.comment.per_page
    @show_projects = Supports::Education::ShowProject
      .new @project, comments, params
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @project = Education::Project.new
  end

  def create
    @project = Education::Project.new project_params
    if @project.save
      technique_service.add
      flash[:success] = t ".project_created"
      redirect_to @project
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js do
        render partial: "education/projects/form",
          locals: {project: @project, button_text: t(".update_project")},
          layout: false
      end
    end
  end

  def update
    if @project.update_attributes project_params
      technique_service.update
      flash[:success] = t ".project_updated_successfully"
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    if @project.destroy
      @projects = Education::Project.newest
      respond_to do |format|
        format.html do
          redirect_to education_projects_path
          flash[:success] = t ".deleted_success"
        end
        format.json{render json: {flash: t(".deleted_success"), status: 200}}
      end
    else
      flash[:danger] = t ".project_delete_fail"
      redirect_to education_root_path
    end
  end

  private
  def project_params
    params.require(:education_project).permit :name, :description,
      :release_note, :core_features, :server_info, :pm_url, :plat_form,
      :git_repo, images_attributes: [:id, :url, :url_cache, :_destroy]
  end

  def load_project
    if @project = Education::Project.find_by(id: params[:id])
      @techniques = @project.techniques
    else
      flash[:danger] = t "education.projects.project_not_found"
      redirect_to education_root_path
    end
  end

  def load_projects_by_technique
    technique_name = params[:technique_name]
    return unless technique_name
    @projects = Education::Project.filter_by_technique(technique_name)
      .includes(:images).page(params[:page])
      .per pagination_by_permission(Education::Project,
        Settings.education.project.per_page,
        Settings.education.project.per_page_trainer)
  end

  def load_project_by_name
    term = params[:term]
    return unless term
    @projects = Education::Project.search_by_name(term).includes(:images)
      .page(params[:page]).per pagination_by_permission(Education::Project,
        Settings.education.project.per_page,
        Settings.education.project.per_page_trainer)
  end

  def show_all_project
    return if params[:term] || params[:technique_name]
    @projects = Education::Project.newest.includes(:images)
      .page(params[:page]).per pagination_by_permission(Education::Project,
        Settings.education.project.per_page,
        Settings.education.project.per_page_trainer)
  end

  def technique_service
    Education::ProjectTechniqueService.new @project, params
  end
end
