module Supports::Education
  class ShowUser
    attr_reader :user, :education_projects, :education_posts,
      :education_courses, :page_param

    def initialize user, page_param
      @user = user
      @page_param = page_param
    end

    def pagination resources
      resources.page(page_param).per Settings.education.trainings.per_page
    end

    def education_projects
      pagination user.education_projects.order(created_at: :desc)
        .includes :images, :translations
    end

    def education_posts
      pagination user.education_posts.order created_at: :desc
    end

    def education_courses
      pagination user.education_courses.order(created_at: :desc)
        .includes :images
    end
  end
end
