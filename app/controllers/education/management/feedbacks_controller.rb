class Education::Management::FeedbacksController <
  Education::Management::BaseController
  load_and_authorize_resource class: Education::Feedback
  before_action :load_feedback, only: :destroy

  def index
    @feedbacks = Education::Feedback.newest.page(params[:page])
      .per Settings.education.feedback.per_page
  end

  def destroy
    if @feedback.destroy
      respond_to do |format|
        format.json{render json: {flash: t(".deleted_success"), status: 200}}
      end
    else
      flash[:danger] = t ".feedback_delete_fail"
      redirect_to education_management_feedbacks_path
    end
  end

  private

  def load_feedback
    return if @feedback = Education::Feedback.find_by(id: params[:id])
    flash[:error] = t ".feedback_not_found"
    redirect_to education_management_feedbacks_path
  end
end
