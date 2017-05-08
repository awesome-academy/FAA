class HomeTabs < Tabs
  private

  def tabs
    [about_tab,
     courses_tab,
     schedule_tab,
     register_tab,
     news_tab,
     recruitment_tab,
     contact_tab].compact
  end

  def about_tab
    build_tab t("education.layouts.header.about"),
      "#", :about
  end

  def courses_tab
    build_tab t("education.layouts.header.courses"),
      education_courses_path, :courses
  end

  def schedule_tab
    build_tab t("education.layouts.header.schedule"),
      "#", :schedule
  end

  def register_tab
    build_tab t("education.layouts.header.register"),
      "#", :register
  end

  def news_tab
    build_tab t("education.layouts.header.news"),
      "#", :news
  end

  def recruitment_tab
    build_tab t("education.layouts.header.recruitment"),
      "#", :recruitment
  end

  def contact_tab
    build_tab t("education.layouts.header.contact"),
      "#", :contact
  end
end
