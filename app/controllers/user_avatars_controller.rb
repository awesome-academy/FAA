class UserAvatarsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_image, only: :update

  def create
    create_avatar
    redirect_to user_path current_user
  end

  def update
    update_avatar
    redirect_to user_path current_user
  end

  private

  def find_image
    @image = current_user.images.find_by id: params[:image_id]
    unless @image
      flash[:danger] = t ".not_found"
      redirect_to user_path current_user
    end
  end

  def create_avatar
    image = current_user.images.build picture: params[:picture]
    if image.save && current_user.update(avatar_id: image.id)
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
  end

  def update_avatar
    if current_user.update avatar_id: @image.id
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
  end
end
