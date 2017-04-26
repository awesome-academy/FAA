class Education::ProgramMember < ApplicationRecord
  belongs_to :user
  belongs_to :learning_program, class_name: Education::LearningProgram.name
end
