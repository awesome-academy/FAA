class Education::UsersController < Education::BaseController
  load_resource

  def show
    if @user.education_status_blocked?
      flash[:danger] = t ".blocked"
      redirect_to root_url
    else
      @show_user_object = Supports::Education::ShowUser.new @user, params[:page]
      @activities = Activity.load_by_current_user(@user).recent
        .pagination params[:page]
    end
  end
end
