class HomeTabs < Tabs
  private

  def tabs
    [home_tab,
     trainings_tab,
     courses_tab,
     projects_tab,
     posts_tab,
     trainers_tab].compact
  end

  def home_tab
    build_tab t("education.layouts.header.home"),
      education_root_path, :home
  end

  def projects_tab
    build_tab t("education.layouts.header.project"),
      education_projects_path, :projects
  end

  def posts_tab
    build_tab t("education.layouts.header.posts"),
      education_posts_path, :posts
  end

  def courses_tab
    build_tab t("education.layouts.header.courses"),
      education_courses_path, :courses
  end

  def trainings_tab
    build_tab t("education.layouts.header.trainings"),
      education_trainings_path, :trainings
  end

  def trainers_tab
    build_tab t("education.layouts.header.trainers"),
      education_trainers_path, :trainers
  end
end
