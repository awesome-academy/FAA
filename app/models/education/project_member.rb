class Education::ProjectMember < ApplicationRecord
  belongs_to :user
  belongs_to :project, class_name: Education::Project.name

  validates :user, uniqueness: {scope: :project}
  enum position: {project_manager: 0, team_leader: 1, designer: 2,
    developer: 3, tester: 4}
end
