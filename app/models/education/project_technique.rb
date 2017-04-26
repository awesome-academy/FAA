class Education::ProjectTechnique < ApplicationRecord
  acts_as_paranoid

  belongs_to :project, ->{with_deleted},
    class_name: Education::Project.name
  belongs_to :technique, ->{with_deleted},
    class_name: Education::Technique.name
end
