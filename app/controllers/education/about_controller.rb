class Education::AboutController < Education::BaseController
  def index
    @trainers = User.trainer.by_active
      .limit(Settings.education.about_page.limit).includes :avatar
  end
end
