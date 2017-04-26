class Education::CourseMembersController < Education::BaseController
  before_action :load_course
  before_action :load_course_member, only: :destroy
  load_and_authorize_resource

  def create
    if params[:users].present?
      user_ids = params[:users]
      Education::CourseMember.transaction do
        user_ids.each do |id|
          course_member = @course.course_members.new user_id: id
          course_member.save!
        end
        render_js t ".success"
      end
    end
  end

  def destroy
    if @course_member.destroy
      render_js t ".success"
    else
      flash[:warning] = t ".delete_fail"
      redirect_to @course
    end
  end

  private

  def load_course
    @course = Education::Course.find_by id: params[:course_id]
    unless @course
      flash[:danger] = t "education.courses.not_found"
      redirect_to education_root_path
    end
  end

  def load_course_member
    @course_member = @course.course_members.find_by user_id: params[:user_id]
    unless @course_member
      flash[:danger] = t "education.course_members.not_found"
      redirect_to education_courses_path
    end
  end

  def render_js message
    @users = User.not_in_object @course
    flash[:success] = message
    respond_to do |format|
      format.js
    end
  end
end
