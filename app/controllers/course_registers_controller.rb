class CourseRegistersController < ApplicationController
  layout "education/layouts/application"

  def new
    @course_register = CourseRegister.new
  end

  def create
    @course_register = CourseRegister.new course_register_params
    if @course_register.save
      flash[:success] = t ".create_success"
      respond_to do |format|
        format.js
      end
      @course_register.send_email params[:course_register][:email],
        params[:course_register][:name]
    else
      flash[:danger] = t ".create_failed"
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
end
