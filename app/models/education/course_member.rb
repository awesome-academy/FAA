class Education::CourseMember < ApplicationRecord
  belongs_to :user
  belongs_to :course, class_name: Education::Course.name

  delegate :avatar, :name, :email, to: :user, prefix: true
end
