class Education::AboutController < Education::BaseController
  def index
    @trainers = Education::Group.get_trainers.users.by_active
      .limit(Settings.education.about_page.limit).includes :avatar
  end
end
