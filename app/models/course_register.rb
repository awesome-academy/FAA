class CourseRegister < ApplicationRecord
  belongs_to :education_course, class_name: Education::Course.name,
    foreign_key: :course_id

  validates :name, presence: true,
    length: {maximum: Settings.course_register.max_name_length,
      minimum: Settings.course_register.min_name_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.course_register.max_email_length},
    format: {with: VALID_EMAIL_REGEX}
  validates :phone_number,
    length: {maximum: Settings.course_register.max_phone_number_length,
      minimum: Settings.course_register.min_phone_number_length},
      allow_blank: true
  validates :address, length:
    {maximum: Settings.course_register.max_address_length,
      minimum: Settings.course_register.min_address_length}, allow_blank: true
  validates :course_id, presence: true

  def send_email user_email, user_name
    CourseRegisterMailer
      .course_register(education_course, user_email, user_name).deliver_later
  end
end
