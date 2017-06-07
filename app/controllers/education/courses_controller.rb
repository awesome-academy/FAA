class Education::CoursesController < Education::BaseController
  before_action :load_course, only: :show

  def index
    @courses = Education::Course.by_training(params[:training_id])
      .order_by_status.includes(:images, :training, :translations)
      .search(name_cont: params[:course_search]).result.page(params[:page])
      .per Settings.courses.index_limit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @show_course = Supports::Education::ShowCourse.new params, @course
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def load_course
    @course = Education::Course.find_by id: params[:id]
    unless @course
      flash[:danger] = t "education.courses.not_found"
      redirect_to education_courses_path
    end
  end
end
