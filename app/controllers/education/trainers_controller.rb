class Education::TrainersController < Education::BaseController
  def index
    @trainers = Education::Group.get_trainers.users
      .by_active.includes :info_user
  end
end
