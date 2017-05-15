class Education::RecruitmentsController < Education::BaseController
  before_action :load_recruitment, only: :show
  before_action :load_user_image_object, only: :show

  def index
    @index_recruitment_object =
      Supports::Education::IndexRecruitment.new params[:page], search_params
  end

  def show
    @recruitment_object = Supports::Education::ShowRecruitment.new @recruitment
  end

  private
  def search_params
    params.permit :content_cont, :user_id_eq, :category_id_eq
  end

  def load_recruitment
    return if @recruitment = Education::Post.find_by(id: params[:id])
    flash[:danger] = t ".recruitment_not_found"
    redirect_to education_recruitments_path
  end

  def load_user_image_object
    @user_image_object = Supports::Education::UserImage.new current_user
  end
end
