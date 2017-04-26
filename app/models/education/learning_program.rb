class Education::LearningProgram < ApplicationRecord
  translates :description, :name

  has_many :members, class_name: Education::ProgramMember.name,
    foreign_key: :learning_program_id
  has_many :users, through: :members

  validates :name, presence: true,
    length: {maximum: Settings.education.index.max_learning_program_name}
end
