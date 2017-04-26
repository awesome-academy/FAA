module Supports::Education
  class NewProject
    attr_reader :project, :users

    def users
      User.all
    end

    def project
      Education::Project.new
    end
  end
end
