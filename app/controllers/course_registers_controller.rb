class CourseRegistersController < ApplicationController
  layout "education/layouts/application"
  before_action :load_course_register, only: :show

  def new
    @course_register = CourseRegister.new
    respond_to do |format|
      format.js
    end
  end

  def show
  end

  def create
    @course_register = CourseRegister.new course_register_params
    if @course_register.save
      flash.now[:success] = t ".create_success"
      respond_to do |format|
        format.js
      end
      @course_register.send_email params[:course_register][:email],
        params[:course_register][:name]
    else
      flash.now[:danger] = t ".create_failed"
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def course_register_params
    params.require(:course_register).permit :course_id, :name, :email, :address,
      :phone_number
  end

  def load_course_register
    return if @course_register = CourseRegister.find_by(id: params[:id])
    flash[:danger] = t ".course_register_not_found"
    redirect_to root_path
  end
end
