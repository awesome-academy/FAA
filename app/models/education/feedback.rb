class Education::Feedback < ApplicationRecord
  validates :name, presence: true,
    length: {maximum: Settings.education.feedback.max_name_length}
  VALID_PHONE_NUMBER_REGEX = /\A([\+]?)+(\d)*\z/
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true,
    length: {maximum: Settings.education.feedback.max_email_length},
    format: {with: VALID_EMAIL_REGEX}
  validates :subject, presence: true,
    length: {minimum: Settings.education.feedback.min_subject_length,
      maximum: Settings.education.feedback.max_subject_length}
  validates :content, presence: true,
    length: {minimum: Settings.education.feedback.min_content_length,
      maximum: Settings.education.feedback.max_content_length}
  validates :phone_number, format: {with: VALID_PHONE_NUMBER_REGEX},
    length: {maximum: Settings.education.feedback.max_phone_number_length}

  scope :newest, ->{order created_at: :desc}
end
