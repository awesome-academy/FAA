class Education::RecruitmentsController < Education::BaseController
  before_action :load_recruitment, only: [:show, :edit, :destroy]
  before_action :load_user_image_object, only: :show

  def index
    @index_recruitment_object =
      Supports::Education::IndexRecruitment.new params[:page], search_params
  end

  def show
    @recruitment_object = Supports::Education::ShowRecruitment.new @recruitment
  end

  def edit
    redirect_to edit_education_post_path(@recruitment)
  end

  def destroy
    if @recruitment.destroy
      flash[:success] = t ".recruitment_delete_success"
    else
      flash[:danger] = t ".recruitment_delete_fail"
    end
    @index_post_object = Supports::Education::IndexRecruitment
      .new params[:page], params[:q]
    respond_to do |format|
      format.html{redirect_to education_recruitments_path}
      format.js
    end
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
