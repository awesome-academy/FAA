class Education::TrainingTechnique < ApplicationRecord
  acts_as_paranoid

  belongs_to :training, ->{with_deleted},
    class_name: Education::Training.name
  belongs_to :technique, ->{with_deleted},
    class_name: Education::Technique.name
end
