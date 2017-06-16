class Education::Feedback < ApplicationRecord
  validates :name, presence: true,
    length: {maximum: Settings.education.feedback.max_name_length}
  VALID_PHONE_NUMBER_REGEX = /\A\+?\d{1,3}?[- .]?\(?(?:\d{2,3})\)?[- .]?\d\d\d[- .]?\d\d\d\d/
  VALID_EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,3}\z/
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
