class Education::AboutController < Education::BaseController
  def index
    @trainers = Education::Group.get_trainers.users.by_active.includes :avatar
  end
end
