class Education::Management::CertificatesController <
  Education::Management::BaseController
  before_action :load_certificate, only: [:edit, :update, :destroy]

  def index
    @certificates = Certificate.page(params[:page])
      .per Settings.education.certificate.per_page
  end

  def new
    @certificate = Certificate.new
    @certificate.build_image
    respond_to do |format|
      format.html
      format.js do
        render partial: "education/management/certificates/form",
          certificate: @certificate,
          button_text: t(".create_certificate"),
          path: education_management_certificates_path,
          layout: false
      end
    end
  end

  def create
    @certificate = Certificate.new certificate_params
    if @certificate.save
      flash[:success] = t ".create_success"
    else
      flash[:danger] = t ".create_fail"
    end
    redirect_to education_management_certificates_path
  end

  def edit
    @certificate.build_image unless @certificate.image
    respond_to do |format|
      format.html
      format.js do
        render partial: "education/management/certificates/form",
          certificate: @certificate,
          button_text: t(".update_certificate"),
          path: education_management_certificate_path(@certificate),
          layout: false
      end
    end
  end

  def update
    if @certificate.update_attributes certificate_params
      flash[:success] = t ".update_success"
    else
      flash[:danger] = t ".update_fail"
    end
    redirect_to education_management_certificates_path
  end

  def destroy
    if @certificate.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:warning] = t ".delete_fail"
    end
    redirect_to education_management_certificates_path
  end

  private

  def load_certificate
    return if @certificate = Certificate.find_by(id: params[:id])
    flash[:error] = t "education.certificates.not_found"
    redirect_to education_management_root_path
  end

  def certificate_params
    params.require(:certificate)
      .permit :title, :description, image_attributes: [:id, :url]
  end
end
