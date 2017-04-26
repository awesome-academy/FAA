class Education::Management::AboutsController <
  Education::Management::BaseController
  load_and_authorize_resource class: Education::About

  def index
    @about = Education::About.first
    @about.build_image if @about.image.blank?
  end

  def update
    about = Education::About.first
    if about.update_attributes about_params
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to education_management_abouts_path
  end

  private

  def about_params
    params.require(:education_about).permit :title, :content,
      image_attributes: [:id, :url]
  end
end
