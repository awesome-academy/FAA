class Education::Management::UserCertificatesController <
  Education::Management::BaseController
  before_action :load_trainer, only: [:edit, :update]
  before_action :load_certificates, only: :edit

  def index
    @trainers = User.trainer
  end

  def update
    if @trainer.update_attributes user_certificates_params
      flash[:success] = t ".update_success"
      redirect_back fallback_location: {action: :index}
    else
      flash[:danger] = t ".update_fail"
      render :edit
    end
  end

  def edit
    respond_to do |format|
      response_text = render_to_string partial: "education/management/user_certificates/form",
        locals: {trainer: @trainer, certificates: @certificates,
        button_text: t(".edit")}, layout: false
      format.html
      format.json do
        render json: {template: response_text}
      end
    end
  end

  private

  def load_trainer
    @trainer = User.includes(:certificates).find_by id: params[:id]
    unless @trainer
      flash[:danger] = t "education.management.user_certificates.not_found"
      redirect_to education_management_user_certificates_path
    end
  end

  def user_certificates_params
    params.require(:user).permit certificates_attributes: [:id, :_destroy]
  end

  def load_certificates
    @certificates = Certificate.all
  end
end
