class Education::RatesController < ApplicationController
  before_action :load_object
  before_action :authenticate_user!

  def create
    @rate = @object.rates.build rate_params
    if @rate.save
      load_object
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = ".create_error"
      redirect_to education_root_path
    end
  end

  private
  def rate_params
    params.require(:education_rate).permit :rate, :user_id, :rateable_type
  end

  def load_object
    @object = case rate_params[:rateable_type]
              when Education::Post.name
                Education::Post.find_by id: params[:post_id]
              when Education::Project.name
                Education::Project.find_by id: params[:project_id]
              end
    unless @object
      flash[:danger] = ".not_found"
      redirect_to education_root_path
    end
  end
end
