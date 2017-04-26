class Education::ImagesController < ApplicationController
  def create
    @image = Education::Image.new url: params[:file], imageable: current_user
    if @image.save
      respond_to do |format|
        format.json{render json: @image}
      end
    else
      respond_to do |format|
        format.json{render json: @image.errors}
      end
    end
  end
end
