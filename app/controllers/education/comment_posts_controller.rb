class Education::CommentPostsController < ApplicationController
  before_action :load_post, only: [:new, :create, :destroy]
  before_action :load_comment, only: [:destroy, :update, :edit]

  def create
    @comment = @post.comments.build comment_params
    if @comment.save
      get_list_comment
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    if @comment.destroy
      load_post
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

  def load_post
    @post = Education::Post.find_by id: params[:post_id]
    not_found unless @post
  end

  def load_comment
    @comment = current_user.education_comments.find_by id: params[:id]
    not_found unless @comment
  end

  def get_list_comment
    load_post
    @post_object = Supports::Education::ShowPost.new @post
    @comments = @post_object.comments
  end
end
