module Supports::Education
  class Home
    attr_reader :about, :projects, :learning_programs, :trainings, :courses,
      :techniques, :courses_select_options, :new_course_register

    def about
      Education::About.first
    end

    def projects
      Education::Project.newest.includes(:images, :translations)
        .limit Settings.home.limit
    end

    def learning_programs
      Education::LearningProgram.includes(:translations)
        .limit Settings.education.index.max_learning_program
    end

    def trainings
      Education::Training.newest.includes(:techniques, :images)
        .limit Settings.home_trainings_limit
    end

    def courses
      Education::Course.newest.includes(:images, :translations)
        .limit Settings.courses.home_limit
    end

    def techniques
      Education::Technique.newest.includes(:image, :translations)
        .limit Settings.education.technique.home_limit
    end

    def trainers
      Education::Group.get_trainers.users.by_active.includes :avatar, :info_user
    end

    def new_course_register
      CourseRegister.new
    end
  end
end
