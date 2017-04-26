class Admin::UsersController < Admin::BaseController
  load_and_authorize_resource

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params.merge(Settings.default_user_password)
    if @user.save
      flash[:success] = t ".user_created"
      redirect_to new_admin_company_path
    else
      flash[:danger] = t ".create_fail"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :phone
  end
end
