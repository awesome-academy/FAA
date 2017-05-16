class ManagementTabs < Tabs
  private

  def tabs
    [group_tab,
     about_tab,
     learning_program_tab,
     feedback_tab,
     technique_tab,
     group_user_tab,
     user_tab,
     category_tab,
     course_registers_tab,
     trainings_tab,
     courses_tab,
     projects_tab].compact
  end

  def about_tab
    build_tab t("education.layouts.header_management.abouts"),
      education_management_abouts_path, :abouts
  end

  def group_tab
    build_tab t("education.layouts.header_management.permissions"),
      education_management_groups_path, :groups
  end

  def learning_program_tab
    build_tab t("education.layouts.header_management.learning_programs"),
      education_management_learning_programs_path, :learning_programs
  end

  def feedback_tab
    build_tab t("education.layouts.header_management.feedbacks"),
      education_management_feedbacks_path, :feedbacks
  end

  def technique_tab
    build_tab t("education.layouts.header_management.techniques"),
      education_management_techniques_path, :techniques
  end

  def group_user_tab
    build_tab t("education.layouts.header_management.group_users"),
      education_management_group_users_path, :group_users
  end

  def user_tab
    build_tab t("education.layouts.header_management.users"),
      education_management_users_path, :users
  end

  def category_tab
    build_tab t("education.layouts.header_management.categories"),
      education_management_categories_path, :categories
  end

  def course_registers_tab
    build_tab t("education.layouts.header_management.course_registers"),
      education_management_course_registers_path, :course_registers
  end

  def courses_tab
    build_tab t("education.layouts.header_management.courses"),
      education_management_courses_path, :courses
  end

  def trainings_tab
    build_tab t("education.layouts.header_management.trainings"),
      education_management_trainings_path, :trainings
  end

  def projects_tab
    build_tab t("education.layouts.header_management.trainings"),
      education_management_projects_path, :projects
  end
end
