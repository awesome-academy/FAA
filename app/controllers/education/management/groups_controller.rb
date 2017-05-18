class Education::Management::GroupsController <
  Education::Management::BaseController

  def index
    @groups = Education::Group.includes :permissions
  end
end
