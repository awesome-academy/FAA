class Education::CommentsController < Education::BaseController
  before_action :load_project, only: [:new, :create, :destroy]
  before_action :load_comment, only: [:destroy, :update, :edit]

  def create
    @comment = @project.comments.build comment_params
    if @comment.save
      @project.reload.comments_count
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    if @comment.destroy
      @project.reload.comments_count
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

  def load_project
    @project = Education::Project.find_by id: params[:project_id]
    render file: Settings.page_404_url unless @project
  end

  def load_comment
    @comment = Education::Comment.find_by id: params[:id]
    render file: Settings.page_404_url unless @comment
  end
end
