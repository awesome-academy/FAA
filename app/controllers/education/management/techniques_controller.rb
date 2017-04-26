class Education::Management::TechniquesController <
  Education::Management::BaseController
  before_action :load_technique, only: [:edit, :update, :destroy]

  def index
    @techniques = Education::Technique.newest
      .includes(:image, :translations).page(params[:page])
      .per Settings.education.technique.per_page
  end

  def new
    @technique = Education::Technique.new
    @technique.build_image
    respond_to do |format|
      format.html
      format.js do
        render partial: "education/management/techniques/form",
          locals: {technique: @technique,
          button_text: t("education.techniques.new.create_technique"),
          path: education_management_techniques_path},
          layout: false
      end
    end
  end

  def create
    @technique = Education::Technique.new technique_params
    if @technique.save
      flash[:success] = t "education.techniques.create.new_success"
    else
      flash[:danger] = t "education.techniques.create.new_faild"
    end
    redirect_to education_management_techniques_path
  end

  def edit
    @technique.build_image unless @technique.image
    respond_to do |format|
      format.html
      format.js do
        render partial: "education/management/techniques/form",
          locals: {technique: @technique,
          button_text: t("education.techniques.edit.update_technique"),
          path: education_management_technique_path(@technique)},
          layout: false
      end
    end
  end

  def update
    if @technique.update_attributes technique_params
      flash[:success] = t ".technique_updated_successfully"
    else
      flash[:danger] = t "education.techniques.update.update_fail"
    end
    redirect_to education_management_techniques_path
  end

  def destroy
    if @technique.destroy
      flash[:success] = t ".technique_deleted"
    else
      flash[:warning] = t ".technique_delete_fail"
    end
    redirect_to education_techniques_path
  end

  private

  def load_technique
    return if @technique = Education::Technique.find_by(id: params[:id])
    flash[:error] = t "education.technique.not_found"
    redirect_to education_root_path
  end

  def technique_params
    params.require(:education_technique)
      .permit :name, :description, image_attributes: [:id, :url]
  end
end
