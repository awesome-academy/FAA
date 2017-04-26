class Education::Feedback < ApplicationRecord
  validates :name, presence: true,
    length: {maximum: Settings.education.feedback.max_name_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.education.feedback.max_email_length},
    format: {with: VALID_EMAIL_REGEX}
  validates :subject, presence: true,
    length: {minimum: Settings.education.feedback.min_subject_length,
      maximum: Settings.education.feedback.max_subject_length}
  validates :content, presence: true,
    length: {minimum: Settings.education.feedback.min_content_length,
      maximum: Settings.education.feedback.max_content_length}
  validates :phone_number,
    length: {maximum: Settings.education.feedback.max_phone_number_length}

  scope :newest, ->{order created_at: :desc}
end
