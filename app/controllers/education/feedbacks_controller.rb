class Education::FeedbacksController < Education::BaseController
  def new
    @feedback = Education::Feedback.new
  end

  def create
    @feedback = Education::Feedback.new feedback_params
    if @feedback.save
      flash[:success] = t "education.feedback.feedback_success"
      redirect_to education_root_url
    else
      flash[:danger] = t "education.feedback.feedback_error"
      render :new
    end
  end

  private

  def feedback_params
    params.require(:education_feedback).permit :name, :email, :phone_number,
      :subject, :content
  end
end
