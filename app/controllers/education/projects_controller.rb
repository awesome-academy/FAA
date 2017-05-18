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

  private

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
      .per Settings.education.project.per_page
  end

  def load_project_by_name
    term = params[:term]
    return unless term
    @projects = Education::Project.search_by_name(term).includes(:images)
      .page(params[:page]).per Settings.education.project.per_page
  end

  def show_all_project
    return if params[:term] || params[:technique_name]
    @projects = Education::Project.newest.includes(:images)
      .page(params[:page]).per Settings.education.project.per_page
  end

  def technique_service
    Education::ProjectTechniqueService.new @project, params
  end
end
