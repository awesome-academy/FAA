class InfoUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    info_user = current_user.build_info_user info_user_params
    if info_user.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to education_user_path current_user
  end

  def update
    if current_user.info_user.update_attributes info_user_params
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to education_user_path current_user
  end

  private

  def info_user_params
    params.require(:info_user).permit :introduce, :birthday, :school
  end
end
