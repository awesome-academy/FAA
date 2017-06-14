class CourseRegister < ApplicationRecord
  belongs_to :education_course, class_name: Education::Course.name,
    foreign_key: :course_id

  validates :name, presence: true,
    length: {maximum: Settings.course_register.max_name_length,
      minimum: Settings.course_register.min_name_length}
  VALID_PHONE_NUMBER_REGEX = /\A([\+]?)+(\d)*\z/
  VALID_EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
  validates :email, presence: true,
    length: {maximum: Settings.course_register.max_email_length},
    format: {with: VALID_EMAIL_REGEX}
  validates :phone_number,
    length: {maximum: Settings.course_register.max_phone_number_length,
      minimum: Settings.course_register.min_phone_number_length},
      allow_blank: true, format: {with: VALID_PHONE_NUMBER_REGEX}
  validates :address, length:
    {maximum: Settings.course_register.max_address_length,
      minimum: Settings.course_register.min_address_length}, allow_blank: true
  validates :course_id, presence: true

  enum status: [:contacted, :registered], _prefix: true

  scope :newest, ->{order created_at: :desc}

  scope :filter_by_status, ->status do
    where status: status if status.present?
  end

  scope :filter_by_name, ->id do
    where(course_id: id) if id.present?
  end

  def send_email user_email, user_name
    CourseRegisterMailer
      .course_register(education_course, user_email, user_name).deliver_later
  end
end
