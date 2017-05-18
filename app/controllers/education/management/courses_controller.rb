class Education::Management::CoursesController <
  Education::Management::BaseController
  before_action :load_course, except: [:index, :new, :create]
  # load_and_authorize_resource except: [:index, :show]

  def index
    @courses = Education::Course.by_training(params[:training_id])
      .newest.includes(:images, :training, :translations)
      .search(name_cont: params[:course_search]).result.page(params[:page])
      .per Settings.courses.index_limit_trainer
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @course = Education::Course.new
    respond_to do |format|
      format.html
      format.js do
        render partial: "education/management/courses/form",
          locals: {course: @course, button_text: t(".create_course"),
          url: education_management_courses_path}, layout: false
      end
    end
  end

  def create
    @course = Education::Course.new course_params
    if @course.save
      flash[:success] = t ".new_success"
      redirect_to education_management_courses_path
    else
      flash[:danger] = t ".new_faild"
      render :new
    end
  end

  def show
    @show_course = Supports::Education::ShowCourse.new params, @course
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js do
        render partial: "education/management/courses/form",
          locals: {course: @course, button_text: t(".edit"),
          url: education_management_course_path}, layout: false
      end
    end
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t ".update_success"
      redirect_back fallback_location: {action: :index}
    else
      flash[:danger] = t ".update_faild"
      render :edit
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_faild"
    end
    redirect_back fallback_location: {action: :index}
  end

  private
  def course_params
    params.require(:education_course).permit :name, :detail, :deadline_register,
      :start_date, :end_date, :training_id, :cost, :place, :schedule,
      images_attributes: [:id, :url, :url_cache, :_destroy]
  end

  def load_course
    @course = Education::Course.find_by id: params[:id]
    unless @course
      flash[:danger] = t "education.courses.not_found"
      redirect_to education_management_courses_path
    end
  end
end
