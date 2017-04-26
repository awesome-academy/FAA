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
     category_tab].compact
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
end
