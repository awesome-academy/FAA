class Education::Management::GroupsController <
  Education::Management::BaseController
  load_and_authorize_resource class: Education::Group

  def index
    @groups = Education::Group.includes :permissions
  end
end
