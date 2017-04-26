class Education::Management::CategoriesController <
  Education::Management::BaseController
  load_and_authorize_resource class: Education::Category
  before_action :find_category, only: [:update, :destroy]

  def index
    @query_categories = Education::Category.ransack params[:q]
    @categories = @query_categories.result.newest
      .page(params[:page]).per Settings.education.management.categories.per_page
    @category = Education::Category.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    category = Education::Category.new category_params
    if category.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to education_management_categories_path
  end

  def update
    if @category.update_attributes category_params
      respond_to_json t(".success"), 200, @category.name
    else
      respond_to_json t(".fail"), 400
    end
  end

  def destroy
    if @category.destroy
      respond_to_json t(".success"), 200
    else
      respond_to_json t(".fail"), 400
    end
  end

  private

  def category_params
    params.require(:education_category).permit :name
  end

  def find_category
    @category = Education::Category.find_by id: params[:id]
    respond_to_json t(".not_found"), 400 unless @category
  end

  def respond_to_json message, status, name = nil
    respond_to do |format|
      format.json{render json: {flash: message, status: status, name: name}}
    end
  end
end
