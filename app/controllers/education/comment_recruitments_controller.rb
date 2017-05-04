class Education::CommentRecruitmentsController < ApplicationController
  before_action :load_recruitment, only: [:new, :create, :destroy]
  before_action :load_comment, only: [:destroy, :update, :edit]

  def create
    @comment = @recruitment.comments.build comment_params
    if @comment.save
      get_list_comment
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    if @comment.destroy
      load_recruitment
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @comment.update_attributes comment_params
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:education_comment).permit :content, :user_id
  end

  def load_recruitment
    @recruitment = Education::Post.find_by id: params[:recruitment_id]
    not_found unless @recruitment
  end

  def load_comment
    @comment = current_user.education_comments.find_by id: params[:id]
    not_found unless @comment
  end

  def get_list_comment
    load_recruitment
    @recruitment_object = Supports::Education::ShowRecruitment.new @recruitment
    @comments = @recruitment_object.comments
  end
end
