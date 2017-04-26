class Education::Management::UsersController <
  Education::Management::BaseController
  load_and_authorize_resource class: User
  before_action :user_exists, only: :update

  def index
    @query_users = User.of_education.ransack params[:q]
    @users = @query_users.result
      .page(params[:page]).per Settings.education.management.users.per_page
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes user_params
        format.json{render json: {flash: t(".success"), status: 200}}
      else
        format.json{render json: {flash: t(".fail"), status: 400}}
      end
    end
  end

  def create
    User.transaction do
      User.import params[:file]
    end
    flash[:success] = t ".success"
    redirect_to education_management_users_path
  rescue => exception
    flash[:danger] = exception.message
    redirect_to education_management_users_path
  end

  private

  def user_params
    params.require(:user).permit :education_status if params[:user]
  end

  def user_exists
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t ".not_found"
      redirect_to education_management_users_path
    end
  end
end
