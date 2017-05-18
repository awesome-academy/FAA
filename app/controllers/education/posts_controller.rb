class Education::PostsController < Education::BaseController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit]
  before_action :load_post, only: [:show]
  before_action :load_user_image_object, only: [:new, :edit, :show, :update]
  before_action :load_post_of_user, only: [:update, :destroy, :edit]
  before_action :new_post_permission, only: [:new]
  before_action :create_post_permission, only: [:update]

  def index
    @index_post_object = Supports::Education::IndexPost.new params[:term],
      params[:page], params[:category], params[:user]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @post = Education::Post.new
    unless Education::Post.post_types.key?(params[:type])
      redirect_back fallback_location: {action: :index}
    end
  end

  def create
    @post = current_user.education_posts.build post_params
    if @post.save
      flash[:success] = t ".post_create_success"
      if @post.post_type == Settings.education.posts.recruitment
        redirect_to education_recruitment_path @post
      else
        redirect_to @post
      end
    else
      load_user_image_object
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update_attributes post_params
      flash[:success] = t ".post_update_success"
      if @post.post_type == Settings.education.posts.recruitment
        redirect_to education_recruitment_path @post
      else
        redirect_to @post
      end
    else
      render :edit
    end
  end

  def show
    @post_object = Supports::Education::ShowPost.new @post
  end

  def destroy
    if @post.destroy
      flash[:success] = t ".post_delete_success"
    else
      flash[:danger] = t ".post_delete_fail"
    end
    @index_post_object = Supports::Education::IndexPost.new params[:term],
      params[:page], params[:category], params[:user]
    respond_to do |format|
      format.html{redirect_to education_posts_path}
      format.js
    end
  end

  private

  def load_post
    return if @post = Education::Post.find_by(id: params[:id])
    flash[:danger] = t ".post_not_found"
    redirect_to education_posts_path
  end

  def post_params
    params.require(:education_post).permit :title, :cover_photo,
      :content, :category_id, :tag_list, :post_type
  end

  def load_user_image_object
    @user_image_object = Supports::Education::UserImage.new current_user
  end

  def load_post_of_user
    @post = Education::Post.find_by id: params[:id]
    not_found unless (can? :manage, @post) || (@post.user == current_user)
  end

  def new_post_permission
    if params[:type] && params[:type] == Settings.education.posts.news &&
      !current_user.admin?
      flash[:danger] = t ".create_post_permission"
      redirect_back fallback_location: {action: :index}
    end
  end

  def create_post_permission
    if params[:education_post][:post_type] == Settings.education.posts.news &&
      !current_user.admin?
      flash[:danger] = t ".create_post_permission"
      redirect_back fallback_location: {action: :index}
    end
  end
end
