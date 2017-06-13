class HomeTabs < Tabs
  private

  def tabs
    [about_tab,
     trainings_tab,
     schedule_tab,
     contact_tab].compact
  end

  def about_tab
    build_tab t("education.layouts.header.about"),
      education_about_index_path, :about
  end

  def trainings_tab
    build_tab t("education.layouts.header.trainings"),
      education_trainings_path, :trainings
  end

  def schedule_tab
    build_tab t("education.layouts.header.schedule"),
      education_courses_path, :courses
  end

  def news_tab
    build_tab t("education.layouts.header.news"),
      education_posts_path, :posts
  end

  def recruitment_tab
    build_tab t("education.layouts.header.recruitment"),
      education_recruitments_path, :recruitments
  end

  def contact_tab
    build_tab t("education.layouts.header.contact"),
      new_education_feedback_path, :feedbacks
  end
end
