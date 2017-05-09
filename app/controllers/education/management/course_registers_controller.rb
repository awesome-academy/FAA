class Education::Management::CourseRegistersController <
  Education::Management::BaseController
  load_and_authorize_resource class: CourseRegister
  before_action :load_course_register, only: :update

  def index
    @query_course_register = CourseRegister.ransack params[:q]
    @course_register = @query_course_register.result
      .filter_by_status(params[:status_course])
      .includes(:education_course).newest.page(params[:page])
      .per Settings.education.course.per_page
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    respond_to do |format|
      if @course_register.update_attributes course_register_params
        format.json{render json: {flash: t(".success"), status: 200}}
      else
        format.json{render json: {flash: t(".fail"), status: 400}}
      end
    end
  end

  private

  def course_register_params
    params.require(:course_register).permit :status if params[:course_register]
  end

  def load_course_register
    @course_register = CourseRegister.find_by id: params[:id]
    unless @course_register
      flash[:danger] = t ".not_found"
      redirect_to education_management_course_registers_path
    end
  end
end
